//
//  ToDoViewController.swift
//  To Do List
//
//  Created by Давид on 28/04/2019.
//  Copyright © 2019 Давид. All rights reserved.
//

import UIKit

class ToDoViewController: UITableViewController {
    
    // MARK: - ... @IBOutlet
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    @IBOutlet weak var notesTextView: UITextView!
    
    // MARK: - ... Stored Properties
    var todo: ToDo?
    
    var isPickerHidden = true
    var datePicher =  false {
        didSet {
            dueDatePicker.isHidden = !datePicher
        }
    }
    
    // MARK: - ... UITableViewController Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let midnightToday = Calendar.current.startOfDay(for: Date())
        dueDatePicker.minimumDate = midnightToday
        
        self.hideKeyboardWhenTappedAround()
       // dueDatePicker.locale = Locale(identifier: "ru_RU")
        
        updateUI()
        
        dueDatePicker.date = Date().addingTimeInterval(24 * 60 * 60)
        
        updateDueDateLable(date: dueDatePicker.date)
        updateSaveButtonState()
    }
    
    // MARK: - ... Custom Method
    func updateDueDateLable(date: Date) {
        dueDateLabel.text = ToDo.dueDateFormatter.string(from: date)
    }
    
    func updateSaveButtonState() {
        let text = titleTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    func updateUI() {
        guard todo != nil else { return }
        titleTextField.text = todo?.title
        isCompleteButton.isSelected = todo!.isComplete
        dueDatePicker.date = todo!.dueDate
        notesTextView.text = todo?.note
        tableView.reloadData()
        
    }
    
    // MARK: - ... @IBAction
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLable(date: dueDatePicker.date)
    }
    
    @IBAction func isCompleteButtonPressed(_ sender: UIButton) {
        isCompleteButton.isSelected.toggle()

    }
    
    @IBAction func returnPressed(_ sender: UITextField) {
        //titleTextField.resignFirstResponder()
    }
    
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }

    
    // MARK: - ... Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "SaveSegue" else { return }
        todo = ToDo(
            title: titleTextField.text!,
            isComplete: isCompleteButton.isSelected,
            dueDate: dueDatePicker.date,
            note: notesTextView.text
        )
    }
    // также можно было стелать через @IBAction
//    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
//        todo = ToDo(value: ["title": titleTextField.text!,        // если не инициализировать свойства
//                            "isComplete": isCompleteButton.isSelected,
//                            "dueDate": dueDatePicker.date,
//                            "note": notesTextView.text ?? ""])
//        do {
//            let realm = try Realm()
//            try realm.write {
//                realm.add(todo!)
//            }
//        } catch let error {
//            print("Error: \(error)")
//        }
//        performSegue(withIdentifier: "SaveSegue", sender: nil)
//    }
    
}

extension ToDoViewController {
    // Убираем клавиатуру при нажатии на поле(не забываем вызвать этот метод во вьюдидлоад self.hideKeyboardWhenTappedAround())
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(ToDoViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.tableView.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        self.tableView.endEditing(true)
    }
}
