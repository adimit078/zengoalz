//
//  happyViewController.swift
//  Zenn Path
//
//  Created by Aditya Mittal on 4/7/21.
//

import UIKit
import CoreData

class happyViewController: UIViewController, UITextFieldDelegate {
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var feelsArray = GlobalVar.globalFeels
    var feelIndex = GlobalVar.globalFeelIndex
    var toDoSuccess = Int()
    
    var newIndex: String = ""
    
    @IBOutlet weak var activity1Field: UITextField!
    @IBOutlet weak var activity2Feild: UITextField!
    
    @IBOutlet weak var goodButton: UIButton!
    @IBOutlet weak var medButton: UIButton!
    @IBOutlet weak var badButton: UIButton!
    @IBOutlet weak var logItButton: UIButton!
    
    @IBOutlet weak var bigView: UIView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.activity1Field.delegate = self
        self.activity2Feild.delegate = self
        
        goodButton.layer.cornerRadius = 20
        goodButton.layer.borderWidth = 1
        goodButton.layer.borderColor = UIColor.black.cgColor
        
        medButton.layer.cornerRadius = 20
        medButton.layer.borderWidth = 1
        medButton.layer.borderColor = UIColor.black.cgColor
        
        badButton.layer.cornerRadius = 20
        badButton.layer.borderWidth = 1
        badButton.layer.borderColor = UIColor.black.cgColor
        
        logItButton.layer.cornerRadius = 30
        bigView.layer.cornerRadius = 20

        loadItems()
    }
    
//How have the ToDos been coming along?
    @IBAction func greatToDoPressed(_ sender: UIButton) {
        toDoSuccess = 3
        
        goodButton.backgroundColor = UIColor.green
        
        medButton.backgroundColor = UIColor.clear
        badButton.backgroundColor = UIColor.clear
    }
    
    @IBAction func medToDoPressed(_ sender: UIButton) {
        toDoSuccess = 2
        
        medButton.backgroundColor = UIColor.systemTeal
        
        goodButton.backgroundColor = UIColor.clear
        badButton.backgroundColor = UIColor.clear
    }
    
    @IBAction func badToDoPressed(_ sender: UIButton) {
        toDoSuccess = 1
        
        badButton.backgroundColor = UIColor.red
        
        goodButton.backgroundColor = UIColor.clear
        medButton.backgroundColor = UIColor.clear
    }

//LOG IT PRESSED
    @IBAction func logItPressed(_ sender: UIButton) {
        //checking that the text box is not empty
        if (activity1Field.text != "" && activity2Feild.text != ""){
            
            //creating new instance of coreData object from the "Item" entity
            let newFeel = Feels(context: self.context)
            
            //Logging user's happiness
            newFeel.feelIndex = Int16(newIndex) ?? 4
            
            //Logging activity1 (WHAT HAVE YOU BEEN UP TO?)
            newFeel.activity = activity1Field.text
            
            //Logging activity2 (WHAT DO YOU LOOK FORWARD TO DOING?)
            newFeel.lookForward = activity2Feild.text
            
            //Level of control with ToDos
            newFeel.controlLevel = Int16(toDoSuccess)
            
            //Date Entered
            //newFeel.dateEntered = Date()
            
            //Appending instance to the array containing all toDo instances
            feelsArray.append(newFeel)
            
            //Saving the str array into coreData
            self.saveItems()
        }
        
        if toDoSuccess > 1 {
            self.performSegue(withIdentifier: "goToHappySuccess", sender: self)
        } else {
            self.performSegue(withIdentifier: "goToHappyFail", sender: self)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
//Save + Load Items
    func saveItems() {
        do{
            try context.save()
        } catch {
            print("error saving context: \(error)")
        }
    }
    
    func loadItems() {
        let request: NSFetchRequest<Feels> = Feels.fetchRequest()
        do {
            feelsArray = try context.fetch(request)
        } catch {
            "error fetching data"
        }
    }
    
}
