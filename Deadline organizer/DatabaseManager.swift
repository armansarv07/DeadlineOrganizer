//
//  DatabaseManager.swift
//  Deadline organizer
//
//  Created by Arman on 18.10.2021.
//

import Foundation
import RealmSwift

let realm = try! Realm()

class DatabaseManager{
    static func saveObject(_ task: Task) {
        try! realm.write {
            realm.add(task)
        }
    }
    
    static func deleteObject(_ task: Task) {
        try! realm.write {
            realm.delete(task)
        }
    }
}
