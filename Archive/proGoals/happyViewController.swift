//
//  happyViewController.swift
//  proGoals
//
//  Created by Aditya Mittal on 12/26/20.
//

import UIKit
import CoreData

//MAIN: STORE WHAT MAKES THE USER HAPPY AND SEE WHAT THEY ARE LOOKING FORWARD TO DOING

class happyViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
   
    //Base choices for activities that make them happy
    var activityChoicesArray = ["Homework","Chores","Games","Workout","Reading","Sports"]
    var activityArray = GlobalVar.activArray
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var activity = ""
    var feelArray = GlobalVar.meanFeel

    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var planningView: UIView!
    
    @IBOutlet weak var activityPicker: UIPickerView!
    
    @IBOutlet weak var addActivityText: UITextField!
    @IBOutlet weak var lookForwardText: UITextField!
    
    @IBOutlet weak var addActivityButton: UIButton!
    
    @IBOutlet weak var logIt: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityPicker.dataSource = self
        activityPicker.delegate = self
        
        //Beautification
        activityView.layer.cornerRadius = 10
        activityView.layer.borderWidth = 1
        
        planningView.layer.cornerRadius = 10
        planningView.layer.borderWidth = 1
        
        addActivityButton.layer.cornerRadius = 5
        addActivityButton.layer.borderWidth = 1
        addActivityButton.layer.borderColor = UIColor.white.cgColor
        
        logIt.layer.cornerRadius = 5
        logIt.layer.borderWidth = 1
        logIt.layer.borderColor = UIColor.purple.cgColor
        
        //Reload the picker based on the picker values
        activityPicker.reloadAllComponents()
        
        //Retrieve all the information from the coreData
        loadItems()
        
    }

//"WHAT HAVE YOU BEEN DOING" PICKER VIEW
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return activityChoicesArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return activityChoicesArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        activity = activityChoicesArray[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        //Adding a choice to the "what have you been doing pickerview"
        let newItem = addActivityText.text!
        activityChoicesArray.append(newItem)
        
        activityPicker.reloadAllComponents()
    }
    
    //Storing all information in coreData
    @IBAction func LogItPressed(_ sender: UIButton) {
        let x = feelArray[feelArray.count - 1]
        print(x)
        x.activity = activity
        print("the activity is: \(activity)")
        x.lookForward = lookForwardText.text
        
        saveItems()

        //getActivity()

        self.performSegue(withIdentifier: "goToHomeYAY", sender: self)
    }
    
    func saveItems() {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func loadItems() {
        let request: NSFetchRequest<Feels> = Feels.fetchRequest()
        do {
            feelArray = try context.fetch(request)
        } catch {
            print(error)
        }
    }
    
    func getActivity() {
        loadItems()
        print("HELLOOOO")
        if feelArray.count != 0 {
            for x in feelArray {
                print(x)
                if x.feelCount == 5 {
                    print(x.activity)
                    activityArray.append(x.activity!)
                }
                
                if x.feelCount == 4 {
                    activityArray.append(x.activity!)
                }
            }
            
            print("\n\(activityArray)")
            
        } else {
            print("NO INFO")
        }
    }
}
