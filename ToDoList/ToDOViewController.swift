//
//  ToDOViewController.swift
//  ToDoList
//
//  Created by Татьяна on 23.10.2018.
//  Copyright © 2018 Denis Bystruev. All rights reserved.
//

import UIKit

class ToDOViewController: UITableViewController {
    
    var todo: ToDo?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var compliteButton: UIButton!
    @IBOutlet weak var seveButton: UIBarButtonItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let todo = self.todo {
            titleTextField.text = todo.title
            datePicker.minimumDate = todo.dueDate
            datePicker.date = todo.dueDate
            noteTextView.text = todo.notes ?? ""
            compliteButton.isSelected = todo.isComplete
            title = "Дело"
        } else {
            datePicker.minimumDate = Date()
            title = "Новое дело"
        }
        updateSaveButtonState()
        updateDateLabel(date: datePicker.date)

    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 1 else { return }
        
        tableView.beginUpdates()
        datePicker.isHidden = !datePicker.isHidden
        tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 1:
            return datePicker.isHidden ? 44 : 200
        case 2:
            return 200
        default:
            return 44
        }
    }
    
    @IBAction func titleFieldChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    @IBAction func doneTapped(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func compliteButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func datePicerChange(_ sender: UIDatePicker) {
        updateDateLabel(date: sender.date)
    }
    
    func updateDateLabel(date: Date) {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "ru_RU")
        dateLabel.text = formatter.string(from: date)
    }
    
    func updateSaveButtonState() {
        seveButton.isEnabled = !(titleTextField.text?.isEmpty ?? true)
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else {
            return
        }
        
        todo = ToDo(title: titleTextField.text!, isComplete: compliteButton.isSelected, dueDate: datePicker.date, notes: noteTextView.text)
    }
    

}

extension ToDOViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        } else {
            return true
        }
    }
}
