//
//  StudentsClass+CoreDataProperties.swift
//  TeacherPhoneBook
//
//  Created by Maksym Teslia on 19.03.2021.
//  Copyright © 2021 Maksym Teslia. All rights reserved.
//
//

import Foundation
import CoreData


extension StudentsClass {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StudentsClass> {
        return NSFetchRequest<StudentsClass>(entityName: "StudentsClass")
    }

    @NSManaged public var nameOfClass: String?
    @NSManaged public var studentsInClass: NSSet?

}

// MARK: Generated accessors for studentsInClass
extension StudentsClass {

    @objc(addStudentsInClassObject:)
    @NSManaged public func addToStudentsInClass(_ value: Student)

    @objc(removeStudentsInClassObject:)
    @NSManaged public func removeFromStudentsInClass(_ value: Student)

    @objc(addStudentsInClass:)
    @NSManaged public func addToStudentsInClass(_ values: NSSet)

    @objc(removeStudentsInClass:)
    @NSManaged public func removeFromStudentsInClass(_ values: NSSet)

}
