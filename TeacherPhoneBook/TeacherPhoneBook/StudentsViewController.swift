//
//  StudentsViewController.swift
//  TeacherPhoneBook
//
//  Created by Maksym Teslia on 18.03.2021.
//  Copyright © 2021 Maksym Teslia. All rights reserved.
//

import UIKit


class StudentsViewController: UIViewController {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static let studentCellIdentifier = "StudentCell"
    @IBOutlet weak var studentsLabel: UILabel!
    @IBOutlet weak var studentsTableView: UITableView!
    var currentClassToWorkWith:StudentsClass?
    var students = [Student]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.studentsTableView.separatorColor = .white
    }
    
    func fetchStudents() {
        
        let currentClassOfStudentsSet = self.currentClassToWorkWith?.studentsInClass
        var arrayOfStudents = [Student]()
        currentClassOfStudentsSet?.forEach({ (element) in
            arrayOfStudents.append(element as! Student)
        })
        do {
            try self.context.save()
        } catch let error {
            print(error)
        }
        self.students = arrayOfStudents
        DispatchQueue.main.async {
            self.studentsTableView.reloadData()
        }
    }
    
    @IBAction func addStudentButton(_ sender: UIButton) {
        initiateAnAllertForStudentCoreDataObjectCreating()
    }
    
    @IBAction func editStudentButton(_ sender: UIButton) {
        let student = students[sender.tag]
        let alertForEdditingStudent = UIAlertController(title: "Редактирование", message: "Обновите информацию", preferredStyle: .alert)
        
        alertForEdditingStudent.addTextField { (studentNameTextField:UITextField!) in
            studentNameTextField.text = student.name
        }
        alertForEdditingStudent.addTextField { (motherNameTextField:UITextField!) in
            motherNameTextField.text = student.motherName
        }
        alertForEdditingStudent.addTextField { (motherPhoneTextField:UITextField!) in
            motherPhoneTextField.text = student.motherPhone
        }
        alertForEdditingStudent.addTextField { (fatherNameTextField:UITextField!) in
            fatherNameTextField.text = student.fatherName
        }
        alertForEdditingStudent.addTextField { (fatherPhoneTextField:UITextField!) in
            fatherPhoneTextField.text = student.fatherPhone
        }
        
        let saveButton = UIAlertAction(title: "Сохранить", style: .default) { (action) in
            let updatedStudentName = alertForEdditingStudent.textFields![0].text
            let updatedMotherName = alertForEdditingStudent.textFields![1].text
            let updatedMotherPhone = alertForEdditingStudent.textFields![2].text
            let updatedFatherName = alertForEdditingStudent.textFields![3].text
            let updatedFatherPhone = alertForEdditingStudent.textFields![4].text
            
            student.name = updatedStudentName
            student.motherName = updatedMotherName
            student.motherPhone = updatedMotherPhone
            student.fatherName = updatedFatherName
            student.fatherPhone = updatedFatherPhone
            
            do {
                try self.context.save()
            } catch let error {
                print(error)
            }
            self.fetchStudents()
        }
        alertForEdditingStudent.addAction(saveButton)
        self.present(alertForEdditingStudent, animated: true)
    }
    
    @IBAction func motherCallButton(_ sender: UIButton) {
        let student = students[sender.tag]
        if let motherPhoneToCall = student.motherPhone {
            if let url = URL(string: "tel://\(motherPhoneToCall)"),
                UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler:nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
    
    @IBAction func fatherCall(_ sender: UIButton) {
        let student = students[sender.tag]
        if let fatherPhoneToCall = student.fatherPhone {
            if let url = URL(string: "tel://\(fatherPhoneToCall)"),
                UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler:nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
    
    @IBAction func backToClassesVC(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension StudentsViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: StudentsViewController.studentCellIdentifier) as! StudentTableViewCell
        let student = students[indexPath.row]
        cell.motherCallButton.tag = indexPath.row
        cell.fatherCallButton.tag = indexPath.row
        cell.editButton.tag = indexPath.row
        cell.setUpCell(with: student)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.visibleSize.height / 2.2
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { (action, view, completionHandler) in
            let studentToRemove = self.students[indexPath.row]
            self.context.delete(studentToRemove)
            do {
                try self.context.save()
            } catch let error {
                print(error)
            }
            self.fetchStudents()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension StudentsViewController {
    
    func initiateAnAllertForStudentCoreDataObjectCreating() {
        
        let alertForAddingStudent = UIAlertController(title: "Добавление ученика", message: "Введите информацию", preferredStyle: .alert)
        
        alertForAddingStudent.addTextField { (studentNameTextField:UITextField!) in
            studentNameTextField.placeholder = "Имя ученика"
        }
        alertForAddingStudent.addTextField { (motherNameTextField:UITextField!) in
            motherNameTextField.placeholder = "Имя матери"
        }
        alertForAddingStudent.addTextField { (motherPhoneTextField:UITextField!) in
            motherPhoneTextField.placeholder = "Телефон матери"
        }
        alertForAddingStudent.addTextField { (fatherNameTextField:UITextField!) in
            fatherNameTextField.placeholder = "Имя отца"
        }
        alertForAddingStudent.addTextField { (fatherPhoneTextField:UITextField!) in
            fatherPhoneTextField.placeholder = "Телефон отца"
        }
        
        let addStudentAction = UIAlertAction(title: "Добавить", style: .default) { (addAction) in
            
            let phoneAbsenceIndicator = "Телефона нет"
            let parentNameAbsenceIndicator = "Имя неизвестно"
            
            if alertForAddingStudent.textFields?[0].text != Optional("") {
                
                let newStudent = Student(context: self.context)
                
                let studentName = alertForAddingStudent.textFields?[0].text
                newStudent.name = studentName
                if alertForAddingStudent.textFields?[1].text != Optional("") {
                    let motherName = alertForAddingStudent.textFields?[1].text
                    newStudent.motherName = motherName
                } else { newStudent.motherName = parentNameAbsenceIndicator }
                
                if alertForAddingStudent.textFields?[2].text != Optional("") {
                    let motherPhone = alertForAddingStudent.textFields?[2].text
                    newStudent.motherPhone = motherPhone
                } else { newStudent.motherPhone = phoneAbsenceIndicator }
                
                if  alertForAddingStudent.textFields?[3].text != Optional("") {
                    let fatherName = alertForAddingStudent.textFields?[3].text
                    newStudent.fatherName = fatherName
                } else { newStudent.fatherName = parentNameAbsenceIndicator }
                
                if  alertForAddingStudent.textFields?[4].text != Optional("") {
                    let fatherPhone = alertForAddingStudent.textFields?[4].text
                    newStudent.fatherPhone = fatherPhone
                } else { newStudent.fatherPhone = phoneAbsenceIndicator }
                
                self.currentClassToWorkWith?.addToStudentsInClass(newStudent)
                
            } else { return }
            
            do {
                try self.context.save()
            }
            catch let error { print(error) }
            self.fetchStudents()
        }
        alertForAddingStudent.addAction(addStudentAction)
        self.present(alertForAddingStudent, animated: true)
    }
}
