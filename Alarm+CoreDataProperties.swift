//
//  Alarm+CoreDataProperties.swift
//  Wakie-Talkie
//
//  Created by jiin on 5/8/24.
//
//

import Foundation
import CoreData


extension Alarm {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Alarm> {
        return NSFetchRequest<Alarm>(entityName: "Alarm")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var time: Date?
    @NSManaged public var language: String?
    @NSManaged public var repeatDays: [Bool]?
    @NSManaged public var aiProfileId: String?
    @NSManaged public var isOn: Bool

}

extension Alarm : Identifiable {

}
