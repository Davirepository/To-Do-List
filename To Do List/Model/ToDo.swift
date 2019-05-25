//
//  ToDo.swift
//  To Do List
//
//  Created by Давид on 27/04/2019.
//  Copyright © 2019 Давид. All rights reserved.
//
import Foundation
import Realm
import RealmSwift

@objcMembers class ToDo: Object {
    dynamic var title: String = ""
    dynamic var isComplete: Bool = false
    dynamic var dueDate: Date = Date()
    dynamic var note: String? = nil
    
    init(title: String, isComplete: Bool, dueDate: Date, note: String) {
        self.title = title
        self.isComplete = isComplete
        self.dueDate = dueDate
        self.note = note
        super.init()
    }
    required init() {
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    // Получить область по умолчанию
    static let realm = try! Realm()
    
    // загрузка данных из базы
    static func loadToDos() -> [ToDo]? {
        var todos = [ToDo]()
        //запрос к данным в базе realm
        let todoObjects = realm.objects(ToDo.self)
        for todo in todoObjects {
            todos.append(todo)
        }
        return todos
    }
    
    //загрузка дефолтных значений
    static func defaultToDos() -> [ToDo] {
        return []
    }
    //форма вывода даты
    static let dueDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateStyle = .short
        formatter.timeStyle = .short
//        formatter.locale = Locale(identifier: "ru_RU") // русифецируем
        return formatter
    }()

}
