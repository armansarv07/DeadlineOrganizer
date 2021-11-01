//
//  NewItemTableVC.swift
//  Deadline organizer
//
//  Created by Arman on 18.10.2021.
//

import UIKit

class NewItemTableVC: UITableViewController {

    @IBOutlet var nameLabel: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var typeLabel: UITextField!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    var currentTask: Task!
    var dateString: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isEnabled = false
        nameLabel.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        setupEditScreen()
    }
    
    func saveTask() {
        let newTask = Task(taskName: nameLabel.text!, deadline: dateString, type: typeLabel.text)
        if currentTask != nil {
            try! realm.write{
                currentTask.taskName = newTask.taskName
                currentTask.deadline = newTask.deadline
                currentTask.type = newTask.type
            }
        }else {
            DatabaseManager.saveObject(newTask)
        }
    }
    
    private func setupEditScreen() {
        if currentTask != nil {
            setupNavigationBar()
            
            nameLabel.text = currentTask.taskName
            typeLabel.text = currentTask.type
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .short
            dateFormatter.locale = Locale(identifier: "ru_RU")
            guard let deadline = dateFormatter.date(from: currentTask.deadline!) else { return }
            datePicker.date = deadline
            
        }
    }
    
    private func setupNavigationBar() {
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        navigationItem.leftBarButtonItem = nil
        title = currentTask.taskName
        saveButton.isEnabled = true
    }
    
    @IBAction func datePicked(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        let dateValue = dateFormatter.string(from: sender.date)
        dateString = dateValue
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
    }
    
}

extension NewItemTableVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldChanged() {
        if nameLabel.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
}
