//
//  toDoViewController.swift
//  proGoals
//
//  Created by Aditya Mittal on 12/13/20.
//

import UIKit
import CoreData

//MAIN: Storing/Presenting user's list of To Do items. Also storing the main attributes of the item (date entered, due date, date completed, priority index, and item name)

class toDoViewController: UIViewController, UITableViewDelegate, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var sizeTracker: UIPickerView!
    
    //Defining base attributes for any given ToDo item
    var str = GlobalVar.globalToDo //Actual array that will be storing all the toDo Items - defined in the GlobalVar func in HomeViewController
    let sizeArray = ["Small","Medium","Large","XLarge"]
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var dueDate = Date()
    var toDoSize = (String)()
    var dateEntered = Date()
    var dateCompleted = Date()
    var toDoItems = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Prints the data file path to locate coreData directory
        print(dataFilePath)
        
        sizeTracker.dataSource = self
        sizeTracker.delegate = self
        
        //Beautification
        addButton.layer.cornerRadius = 5
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor = UIColor.white.cgColor
        
        addView.layer.cornerRadius = 15
        addView.layer.borderWidth = 1
        addView.layer.borderColor = UIColor.white.cgColor
        
        datePicker.layer.cornerRadius = 5
        
        myTableView.layer.cornerRadius = 15
        myTableView.reloadData()
        
        sizeTracker.reloadAllComponents()

        //Retrieve all information from coreData directory as soon as screen opens (view actual function below)
        loadItems()
    }
    
//PRIORITY PICKERVIEW
    //Number of rows in the priority slider (Small, Medium, Large, and XLarge)
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sizeArray.count
    }
    
    //Displaying actual text for priority level: (Small, Medium, Large, and XLarge)
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sizeArray[row]
    }
    
    //Capturing selected priority level by setting "toDoSize" as user's selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        toDoSize = sizeArray[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
//TODO ITEM TABLE VIEW
    //Recording the number of rows in the table view == #of ToDos in the coreData directory
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return str.count
    }
    
    //Reloading data everytime loaded
    override func viewDidAppear(_ animated: Bool) {
        myTableView.reloadData()
    }
    
    //actual text displayed in table view == the to dos + a checkmark indicating completion
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let item = str[indexPath.row]
        
        cell.textLabel?.text = item.title

        cell.accessoryType = item.done ? .checkmark : .none

        return cell
    }
    
    //Marking the toDo completed when user selects it, storing dateCompleted attribute
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        str[indexPath.row].done = !str[indexPath.row].done
        
        
        let newItem = Item(context: self.context)
        dateCompleted = Date()
        print("The date you have completed: \(str[indexPath.row])     \(dateCompleted)")
        newItem.dateCompleted = dateCompleted
        
        saveItems()

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Deleting toDo from table view when user slides to delete it
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete{
            
            print(str)
            print(indexPath.row)
            
            context.delete(str[indexPath.row])
            self.str.remove(at: indexPath.row)
            
            self.saveItems()
            loadItems()

            myTableView.reloadData()
        }
    }
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var inputToDo: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    @IBAction func inputToDo(_ sender: Any) {
    }
    
    //setting the dueDate variable to the date the user selected, ending the keyboard from the input text box
    @IBAction func datePickerSelected(_ sender: Any) {
        dueDate = datePicker.date
        inputToDo.endEditing(true)
    }
    
    //adding the item to the toDo list + table view
    @IBAction func addPressed(_ sender: Any) {
        //ending the keyboard from the input text box
        inputToDo.endEditing(true)
        
        //checking that the text box is not empty
        if (inputToDo.text != ""){
            
            //creating new instance of coreData object from the "Item" entity
            let newItem = Item(context: self.context)
            
            //Editing new instance and adding the attributes
            newItem.title = inputToDo.text! //ITEM NAME
            newItem.done = false //STATUS
            
            dueDate = datePicker.date //capturing the due date user entered
            newItem.dueDate = dueDate //setting the item's due date to the date user entered
            
            dateEntered = Date() //capturing the date user entered the toDo item
            newItem.dateEntered = dateEntered //setting the item's dateEntered to the date user entered
            
            //Adding the priority of the item to coreData instance
            if toDoSize == "Small" {
                newItem.size = 1
            }
            if toDoSize == "Medium" {
                newItem.size = 2
            }
            if toDoSize == "Large" {
                newItem.size = 3
            }
            if toDoSize == "XLarge" {
                newItem.size = 4
            }
            
            //Appending instance to the array containing all toDo instances
            str.append(newItem)
            
            //Saving the str array into coreData
            self.saveItems()

            //reloading the tableView to include the new item entered
            self.myTableView.reloadData()
            
            //reseting the textbox to a blank
            inputToDo.text = ""
        }
    }
    
    //storing the str array into coreData while reloading data
    func saveItems() {
        
        do {
            try context.save()
        } catch {
            print("ERROR \(error)")
        }
    
        self.myTableView.reloadData()
    }
    
    //Retrieving all items in coreData "Item" entity
    func loadItems() {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        do {
            str = try context.fetch(request)
        } catch {
            print(error)
        }
    }
}
