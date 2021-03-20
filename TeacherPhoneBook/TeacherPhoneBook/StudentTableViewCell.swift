//
//  StudentTableViewCell.swift
//  TeacherPhoneBook
//
//  Created by Maksym Teslia on 18.03.2021.
//  Copyright © 2021 Maksym Teslia. All rights reserved.
//

import UIKit

class StudentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var motherName: UILabel!
    @IBOutlet weak var motherPhone: UILabel!
    @IBOutlet weak var fatherName: UILabel!
    @IBOutlet weak var fatherPhone: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var motherCallButton: UIButton!
    @IBOutlet weak var fatherCallButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .systemGroupedBackground
        layer.cornerRadius = 25
        layer.borderWidth = 3
        layer.borderColor = UIColor.white.cgColor
        layer.shadowColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.5)
        layer.shadowOpacity = 1
        layer.shadowRadius = 5
        layer.shadowOffset = .zero
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpCell(with student:Student) {
        
        studentName.text = student.name
        motherName.text = student.motherName
        motherPhone.text = student.motherPhone
        fatherName.text = student.fatherName
        fatherPhone.text = student.fatherPhone
        layer.cornerRadius = 25
    }
}
