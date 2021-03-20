//
//  Student+CoreDataProperties.swift
//  TeacherPhoneBook
//
//  Created by Maksym Teslia on 19.03.2021.
//  Copyright © 2021 Maksym Teslia. All rights reserved.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var fatherName: String?
    @NSManaged public var fatherPhone: String?
    @NSManaged public var motherName: String?
    @NSManaged public var motherPhone: String?
    @NSManaged public var name: String?
    @NSManaged public var studentClass: StudentsClass?

}
