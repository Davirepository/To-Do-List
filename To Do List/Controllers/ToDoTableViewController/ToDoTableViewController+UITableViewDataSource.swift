//
//  ToDoTableViewController+UITableViewDataSource.swift
//  To Do List
//
//  Created by Давид on 27/04/2019.
//  Copyright © 2019 Давид. All rights reserved.
//

import UIKit

//заполнение
extension ToDoTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell") else {
            print("Error in \(#file.name) in \(#function) at line \(#line): can't dequeue ToDoCell")
            fatalError()
            
        }
        
        let todo = todos[indexPath.row]
        
        cell.textLabel?.text = todo.title
        cell.detailTextLabel?.text = "\(todo.dueDate)"
        //Пометка завершенных дел
        cell.accessoryType = todo.isComplete ? .checkmark : .none
        
        return cell
    }
}
