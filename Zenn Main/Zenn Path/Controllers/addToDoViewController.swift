//
//  AddToDoViewController.swift
//  Zenn Path
//
//  Created by Aditya Mittal on 4/4/21.
//

import UIKit
import CoreData
import UserNotifications

class AddToDoViewController: UIViewController, UITextFieldDelegate {
    
    
    //Mark:- Outlet
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var newToDoText: UITextField!
    @IBOutlet weak var newToDoDate: UIDatePicker!
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var prioritySlider: UISlider!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var sizeSlider: UISlider!
    
    // MARK: - PROPERTY
    var priorityLevel = GlobalVar.priorityLevel
    var dueDate = GlobalVar.dueDate
    var size = GlobalVar.size
    var str = GlobalVar.globalToDo
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    // MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath)
        
        loadItems()
        newToDoText.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    // MARK: - ALL IBAction METHOD
    @IBAction func prioritySlider(_ sender: UISlider) {
        let x = Int(prioritySlider.value)
        priorityLevel = x
        
        if x == 0 {
            priorityLabel.text = "None"
        } else if x == 1 {
            priorityLabel.text = "Low"
        } else if x == 2 {
            priorityLabel.text = "Medium"
        } else if x == 3 {
            priorityLabel.text = "High"
        }
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        let x = Int(sizeSlider.value)
        size = x
        
        if x == 0 {
            sizeLabel.text = "Extra Small"
        } else if x == 1 {
            sizeLabel.text = "Small"
        } else if x == 2 {
            sizeLabel.text = "Medium"
        } else if x == 3 {
            sizeLabel.text = "Large"
        } else if x == 4 {
            sizeLabel.text = "Exra Large"
        }
    }
    
    //MARK:- DATE PICKER
    @IBAction func datePickerPressed(_ sender: Any) {
        dueDate = newToDoDate.date
        newToDoText.endEditing(true)
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        //Mark:- ending the keyboard from the input text box
        newToDoText.endEditing(true)
        
        //Mark:- checking that the text box is not empty
        if (newToDoText.text != ""){
            
            //Mark:- creating new instance of coreData object from the "Item" entity
            let newItem = Item(context: self.context)
            
            //Mark:- Editing new instance and adding the attributes
            newItem.title = newToDoText.text! //ITEM NAME
            newItem.done = false //STATUS
            
            //Mark:- capturing the due date user entered
            newItem.dueDate = dueDate //setting the item's due date to the date user entered
            
            newItem.dateEntered = Date() //setting the item's dateEntered to the date user entered
            
            //Mark:- Adding the priority of the item to coreData instance
            newItem.priority = Int16(priorityLevel)
            
            //MArk:- Adding the size of ToDo item
            newItem.size = Int16(size)
            
            //Mark:- Appending instance to the array containing all toDo instances
            str.append(newItem)
            
            //Mark:- Saving the str array into coreData
            self.saveItems()
            
            //MARK:- SETTING A NOTIFICATION FOR A DUE DATE
            let center = UNUserNotificationCenter.current()
            
            //Mark:-Notif Text
            let content = UNMutableNotificationContent()
            content.title = "Upcoming ToDo Item!"
            content.body = "Your ToDo called '\(newItem.title!)' is due tommorow! Make sure to work on it!"
            
            //Mark:- Notif Trigger
            let enteredDate = dueDate
            let newDate = Calendar.current.date(byAdding: .day, value: -1, to: dueDate)
            
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "MM-dd-yyyy HH:mm"
            let enteredDatePretty = inputFormatter.string(from: enteredDate)
            let newDatePretty = inputFormatter.string(from: newDate!)
            
            print("entered date: \(enteredDatePretty)")
            print("new date: \(newDatePretty)")
            
            let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: newDate!)
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            //MARK:- Create Request
            let identifier = UUID().uuidString
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            
            //Mark:- Register Request
            center.add((request)) { (error) in
                if error != nil {
                    print("there is an error: \(error?.localizedDescription ?? "error")")
                }
            }
            
            print("the due date of \(newToDoText.text!) is \(dueDate)")
            dismiss(animated: true, completion: nil)
            
            //Mark:- reseting the textbox to a blank
            newToDoText.text = ""
        }
        dismiss(animated: true, completion: nil)
    }
    
    //MARK:- UITextField DELEGATE METHOD
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
    
    //MARK:- DATABSE SAVE + LOAD ITEMS
    func saveItems() {
        
        do{
            try context.save()
        } catch {
            print("error saving context: \(error)")
        }
    }
    
    func loadItems() {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        do {
            str = try context.fetch(request)
        } catch {
            "error fetching data"
        }
    }
}
