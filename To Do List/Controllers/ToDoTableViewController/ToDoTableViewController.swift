//
//  ToDoViewController.swift
//  To Do List
//
//  Created by Давид on 27/04/2019.
//  Copyright © 2019 Давид. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class ToDoTableViewController: UITableViewController {
    
    // MARK: - ... Stored Properties
    var todos = [ToDo]() {              //связываем модель с контроллером
        didSet {
            try! ToDo.realm.write {         // сохраняем данные при записи/использовании модели
                ToDo.realm.add(todos)
            }
        }
    }
    
    // MARK: - ... UITableViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //загрузка данных с базы Realm или загрузка дефолтных значений
        if let savedToDo = ToDo.loadToDos() {       // есть данные
            todos = savedToDo
        } else {                                    // нет данных
            todos = ToDo.defaultToDos()
        }
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        //todos = ToDo.loadToDos()
    }
    
    // MARK: - ... Navigation
    // редактирование
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ShowDetail" else { return }
        guard let toDoViewController = segue.destination as? ToDoViewController else { return }
        guard let path = tableView.indexPathForSelectedRow?.row else { return }
        toDoViewController.todo = todos[path]
        toDoViewController.navigationItem.title = "Edit To Do"
    }
    
    // передача данных на исходный экран при сохранении деталей
    @IBAction func unwind(segue: UIStoryboardSegue) {
        guard segue.identifier == "SaveSegue" else { return }
        guard let toDoViewController = segue.source as? ToDoViewController else { return }
        
        guard let todo = toDoViewController.todo else { return }
        
        if let path = tableView.indexPathForSelectedRow {
            // replace row
            try! ToDo.realm.write {
                ToDo.realm.delete(todos[path.row])
            }
            todos[path.row] = todo
            tableView.deselectRow(at: path, animated: false)
        } else {
            // add row
            todos.append(todo)
        }
        tableView.reloadData()
    }
}



