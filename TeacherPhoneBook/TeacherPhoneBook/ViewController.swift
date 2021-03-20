//
//  ViewController.swift
//  TeacherPhoneBook
//
//  Created by Maksym Teslia on 18.03.2021.
//  Copyright © 2021 Maksym Teslia. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let collectionViewCellIdentifier = "classesCollectionViewCell"
    @IBOutlet weak var classesCollectionView: UICollectionView!
    var classesOfStudents = [StudentsClass]()
    var currentClassOfStudents:StudentsClass?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        classesCollectionView.delegate = self
        classesCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchClasses()
    }
    
    func deleteAllData(entity : String) {
        let context = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
        }
        catch let error { print (error) }
    }
    
    func fetchClasses() {
        do {
            try classesOfStudents = context.fetch(StudentsClass.fetchRequest())
            DispatchQueue.main.async {
                self.classesCollectionView.reloadData()
            }
        } catch let error { print(error) }
    }
    
    @IBAction func addClassButton(_ sender: UIButton) {
        
        let addingNewClassAlert = UIAlertController(title: "Добавление класса", message: "Введите информацию", preferredStyle: .alert)
        addingNewClassAlert.addTextField { (classNameTextField:UITextField!) in
            classNameTextField.placeholder = "Номер класса"
        }
        let addingNewClassAction = UIAlertAction(title: "Добавить", style: .default) { (action) in
            if addingNewClassAlert.textFields?[0].text != Optional("") {
                let classOfStudents = StudentsClass(context: self.context)
                let className = addingNewClassAlert.textFields?[0].text
                classOfStudents.nameOfClass = className
            }
            do {
                try self.context.save()
            }
            catch let error { print(error) }
            
            self.fetchClasses()
        }
        addingNewClassAlert.addAction(addingNewClassAction)
        self.present(addingNewClassAlert, animated: true)
    }
}

extension ViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return classesOfStudents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellIdentifier, for: indexPath) as! StudentsClassCollectionViewCell
        let classToSetUp = classesOfStudents[indexPath.row]
        cell.setUpCell(with: classToSetUp)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let particularClassVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "studentVC") as! StudentsViewController
        particularClassVC.modalPresentationStyle = .fullScreen
        self.present(particularClassVC, animated: true, completion: {
            particularClassVC.currentClassToWorkWith = self.classesOfStudents[indexPath.row]
            particularClassVC.fetchStudents()
        })
    }
}
