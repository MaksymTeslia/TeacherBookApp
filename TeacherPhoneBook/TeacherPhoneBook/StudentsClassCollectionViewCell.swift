//
//  StudentsClassCollectionViewCell.swift
//  TeacherPhoneBook
//
//  Created by Maksym Teslia on 19.03.2021.
//  Copyright © 2021 Maksym Teslia. All rights reserved.
//

import UIKit

class StudentsClassCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var className: UILabel!
    let longPressGestureRecognizer = UILongPressGestureRecognizer()
    let delegate = ViewController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .systemGroupedBackground
        layer.cornerRadius = 10
        addGestureRecognizer(longPressGestureRecognizer)
    }
    
    func setUpCell(with studentClass:StudentsClass) {
         className.text = studentClass.nameOfClass
    }
}

