//
//  ToDo.swift
//  ToDoList
//
//  Created by Denis Bystruev on 22/10/2018.
//  Copyright © 2018 Denis Bystruev. All rights reserved.
//

import Foundation

struct ToDo: Codable {
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    static func loadToDos() -> [ToDo]? {
        let propertyListDecoder = PropertyListDecoder()
        if let data = try? Data(contentsOf: fileURL),
            let decodedToDos = try? propertyListDecoder.decode([ToDo].self, from: data) {
            return decodedToDos
        } else {
            return nil
        }
    }
    
    static func saveToDos(_ todos: [ToDo]) {
        let propertyListEncoder = PropertyListEncoder()
        let encodedNotes = try? propertyListEncoder.encode(todos)
        
        // Запись заметки в файл
        try? encodedNotes?.write(to: fileURL, options: .noFileProtection)
    }
    
    static var documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static var fileURL = documentsDirectory.appendingPathComponent("todoList").appendingPathExtension("plist")
    
    static func loadSampleToDos() -> [ToDo] {
        return [
            ToDo(title: "Дело 1", isComplete: false, dueDate: Date(), notes: "Заметка 1"),
            ToDo(title: "Дело 2", isComplete: false, dueDate: Date(), notes: "Заметка 2"),
            ToDo(title: "Дело 3", isComplete: false, dueDate: Date(), notes: "Заметка 3"),
            ToDo(title: "Дело 4", isComplete: false, dueDate: Date(), notes: "Заметка 4"),
        ]
    }
}
