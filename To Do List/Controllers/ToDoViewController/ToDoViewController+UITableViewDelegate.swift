//
//  ToDoViewController+UITableViewDelegate.swift
//  To Do List
//
//  Created by Давид on 28/04/2019.
//  Copyright © 2019 Давид. All rights reserved.
//

import UIKit

extension ToDoViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let normalHeight = CGFloat(44)
        let largeHeight = CGFloat(200)
        
        switch indexPath {
        case IndexPath(row: 0, section: 1):
            return normalHeight
        case IndexPath(row: 1, section: 1):
            return isPickerHidden ? 0 : largeHeight
        case IndexPath(row: 0, section: 2):
            return largeHeight
        default:
            return normalHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case IndexPath(row: 0, section: 1):
            isPickerHidden.toggle()
            datePicher.toggle()
            tableView.beginUpdates()
            tableView.endUpdates()
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
