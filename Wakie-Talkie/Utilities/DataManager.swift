//
//  DataManager.swift
//  Wakie-Talkie
//
//  Created by jiin on 5/8/24.
//

import CoreData
import Foundation

// Main data manager to handle the todo items
class DataManager: NSObject, ObservableObject {
    
    @Published var alarms: [Alarm] = [Alarm]()
    
    // Add the Core Data container with the model name
    let container: NSPersistentContainer = NSPersistentContainer(name: "Alarm")
    
    // Default init method. Load the Core Data container
    override init() {
        super.init()
        container.loadPersistentStores { _, _ in }
    }
}
