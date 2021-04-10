//
//  addToDoViewController.swift
//  Zenn Path
//
//  Created by Aditya Mittal on 4/4/21.
//

import UIKit
import CoreData

class addToDoViewController: UIViewController {

    var str = GlobalVar.globalToDo
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var addButton: UIButton!
    
    //ToDoName
    @IBOutlet weak var newToDoText: UITextField!
    
    //Date
    @IBOutlet weak var newToDoDate: UIDatePicker!
    
    //Priority
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var prioritySlider: UISlider!
    
    //Size
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var sizeSlider: UISlider!
    
    var priorityLevel = GlobalVar.priorityLevel
    var dueDate = GlobalVar.dueDate
    var size = GlobalVar.size
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath)
        
        myView.layer.cornerRadius = 10
        addButton.layer.cornerRadius = 30
        
        loadItems()
    }
//Priority Slider (0-3)
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
    
//Size Slider (0-4)
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
    
//Date
    @IBAction func datePickerPressed(_ sender: Any) {
        dueDate = newToDoDate.date
        newToDoText.endEditing(true)
    }
    
//Adding New ToDo to tableView
    @IBAction func addButtonPressed(_ sender: Any) {
        //ending the keyboard from the input text box
        newToDoText.endEditing(true)
        
        //checking that the text box is not empty
        if (newToDoText.text != ""){
            
            //creating new instance of coreData object from the "Item" entity
            let newItem = Item(context: self.context)
            
            //Editing new instance and adding the attributes
            newItem.title = newToDoText.text! //ITEM NAME
            newItem.done = false //STATUS
            
            //capturing the due date user entered
            newItem.dueDate = dueDate //setting the item's due date to the date user entered
            
            newItem.dateEntered = Date() //setting the item's dateEntered to the date user entered
            
            //Adding the priority of the item to coreData instance
            newItem.priority = Int16(priorityLevel)
            
            //Adding the size of ToDo item
            newItem.size = Int16(size)
            
            //Appending instance to the array containing all toDo instances
            str.append(newItem)
            
            //Saving the str array into coreData
            self.saveItems()
            
            //reseting the textbox to a blank
            newToDoText.text = ""
        }
        
        dismiss(animated: true, completion: nil)
    }
    
//Save Items + Load Items
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
