//
//  TaskModel.swift
//  Deadline organizer
//
//  Created by Arman on 18.10.2021.
//

import Foundation
import RealmSwift
class Task: Object {
    @objc dynamic var taskName = ""
    @objc dynamic var deadline: String?
    @objc dynamic var type: String?
    
    convenience init(taskName: String, deadline: String?, type: String?) {
        self.init()
        self.taskName = taskName
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "ru_RU")
        self.deadline = deadline
        self.type = type
    }
}
