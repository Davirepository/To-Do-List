//
//  ToDoTableViewController+UITableViewDelegate.swift
//  To Do List
//
//  Created by Давид on 27/04/2019.
//  Copyright © 2019 Давид. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

// редактирование
extension ToDoTableViewController {
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            try! ToDo.realm.write {
                ToDo.realm.delete(todos[indexPath.row])
            }
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .insert:
            break
        case .none:
            break
        @unknown default:
            break
        }
    }
    
}
