//
//  DataManager.swift
//  Diary
//
//  Created by 성재 on 3/2/24.
//

import Foundation
import CoreData

// Main data manager to handle the DB_core items
class DataManager: NSObject, ObservableObject {
    
    @Published var todos: [DB_core] = [DB_core]()
    
    // Add the Core Data container with the model name
    let container: NSPersistentContainer = NSPersistentContainer(name: "Diarydb")
    
    // Default init method. Load the Core Data container
    override init() {
        super.init()
        container.loadPersistentStores { _, _ in }
    }
}
