//
//  sadViewController.swift
//  proGoals
//
//  Created by Aditya Mittal on 1/31/21.
//

import UIKit
import CoreData

class sadViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
//Base choices for activities that make them happy
    var feelChoicesArray = ["Tired","Bored","Relationship Issues","Overworked","Didnt preform well"]
    var activityArray = [""]
    var activity = ""
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var feelArray = GlobalVar.meanFeel
    
    @IBOutlet weak var sadView: UIView!
    @IBOutlet weak var feelingView: UIPickerView!
    @IBOutlet weak var addTextFeild: UITextField!
    @IBOutlet weak var addToSliderButton: UIButton!
    @IBOutlet weak var logItButton: UIButton!
    @IBOutlet weak var reccomendView: UIView!
    @IBOutlet weak var reccomendText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feelingView.dataSource = self
        feelingView.delegate = self
        
        sadView.layer.cornerRadius = 25
        sadView.layer.borderWidth = 1
        
        reccomendView.layer.cornerRadius = 25
        reccomendView.layer.borderWidth = 1
        
        addToSliderButton.layer.cornerRadius = 5
        addToSliderButton.layer.borderWidth = 1
        addToSliderButton.layer.borderColor = UIColor.white.cgColor
        
        logItButton.layer.cornerRadius = 5
        logItButton.layer.borderWidth = 1
        logItButton.layer.borderColor = UIColor.systemIndigo.cgColor

        feelingView.reloadAllComponents()
        
        loadItems()
        
        getActivity()

        // Do any additional setup after loading the view.
    }
    
    //"WHAT HAVE YOU BEEN DOING" PICKER VIEW
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return feelChoicesArray.count
        }
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return feelChoicesArray[row]
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            activity = feelChoicesArray[row]
        }
        
        func numberOfComponents(in feelingView: UIPickerView) -> Int {
            return 1
        }
        
        @IBAction func addButtonPressed(_ sender: UIButton) {
            //Adding a choice to the "what have you been doing pickerview"
            let newItem = addTextFeild.text!
            feelChoicesArray.append(newItem)
            
            feelingView.reloadAllComponents()
        }
        
    @IBAction func logItPressed(_ sender: UIButton) {
        print(feelArray)
        
        let x = feelArray[feelArray.count - 1]
        x.activity = activity
        
        saveItems()
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
        var activities = [String]()
        loadItems()
        if feelArray.count != 0{
            for x in feelArray {
                if x.feelCount >= 4 {
                    activities.append(x.activity!)
                }
            }
            
            reccomendText.text = "\(activities.randomElement()!), \(activities.randomElement()!), \(activities.randomElement()!)"
        } else {
            reccomendText.text = "No sufficient data"
        }
        
        
        
        /*
        if feelArray.count != 0 {
            for x in feelArray {
                if x.feelCount == 5 {
                    activityArray.append(x.activity!)
                }
                
                if x.feelCount == 4 {
                    activityArray.append(x.activity!)
                }
            }
            
            
            
            
        } else {
            print("NO INFO")
        }
         */
    }
    
}
