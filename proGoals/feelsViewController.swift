//
//  feelsViewController.swift
//  proGoals
//
//  Created by Aditya Mittal on 12/26/20.
//

import UIKit
import CoreData

//MAIN: Storing how the user feels along with what activities make them happy

class feelsViewController: UIViewController {
    
    //Create the basic arrays
    var feelArray = GlobalVar.meanFeel
    var average = Float(0)
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Feels.plist")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var feelsView: UIView!
    @IBOutlet weak var feelingPrediction: UILabel!
    @IBOutlet weak var fpImage: UIImageView!
    @IBOutlet weak var averageFeelText: UILabel!
    @IBOutlet weak var averageFeelImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Beautification
        feelsView.layer.cornerRadius = 25
        feelsView.layer.borderWidth = 1
        
        //Load the recent feels and get all information from "Feels" coreData directory
        loadItems()
        
        //Updating the view with the correct average feeling and accompanying image
        updateView()
    }
    
    //EACH BUTTON CORRESPONDES TO AN EMOTION RANGING FROM 1-5, 1 BEING SAD AND 5 HAPPY (ALL BUTTONS FOLLOW THE SAME CODE FORMAT)
    @IBAction func sadPressed(_ sender: UIButton) {
        //Initiate a new instance of Feels from coreData
        let newFeel = Feels(context: self.context)
        
        newFeel.dateEntered = Date()//Date entered

        //Checking that the user has entered an emotion before (does the array contain any information?)
        if feelArray.count != 0 {
            //recall the previous instance
            let x = feelArray[feelArray.count - 1]
            //add 1 to the previous count to signify the user recorded another feeling
            newFeel.feelingClickedCount = x.feelingClickedCount + 1
            //add 1 to the feeling (1 because this button is sad: 1-Very Sad, 2-Sad, 3-Medium, 4-Happy, 5-Very Happy)
            newFeel.feelIndex = x.feelIndex + 1
            //average by taking the sum of feel values (feelIndex) and dividing by the total number of times user recorded a feel (clicked count)
            newFeel.feelsAverage = newFeel.feelIndex/newFeel.feelingClickedCount
            //saving the feel count
            newFeel.feelCount = 1
            
            //add new instance to feelArray
            feelArray.append(newFeel)
        } else {
            //if the feelArray does not have any prior values (first time launching app), create a "blank" instance
            newFeel.feelingClickedCount = 1
            newFeel.feelIndex = 1
            newFeel.feelsAverage = newFeel.feelIndex/newFeel.feelingClickedCount
            //saving the feel count
            newFeel.feelCount = 1
            feelArray.append(newFeel)
        }
                
        //Save/Update
        saveItems()
        updateView()
    }
    
    @IBAction func medSadPressed(_ sender: UIButton) {
        let newFeel = Feels(context: self.context)
        newFeel.dateEntered = Date()

        if feelArray.count != 0 {
            let x = feelArray[feelArray.count - 1]
            newFeel.feelingClickedCount = x.feelingClickedCount + 1
            newFeel.feelIndex = x.feelIndex + 2
            newFeel.feelsAverage = newFeel.feelIndex/newFeel.feelingClickedCount
            newFeel.feelCount = 2
            
            feelArray.append(newFeel)
        } else {
            newFeel.feelingClickedCount = 1
            newFeel.feelIndex = 2
            newFeel.feelsAverage = newFeel.feelIndex/newFeel.feelingClickedCount
            newFeel.feelCount = 2
            feelArray.append(newFeel)
        }

        saveItems()
        updateView()
        print(feelArray)
    }
    
    @IBAction func mehPressed(_ sender: UIButton) {
        let newFeel = Feels(context: self.context)
        newFeel.dateEntered = Date()

        if feelArray.count != 0 {
            let x = feelArray[feelArray.count - 1]
            newFeel.feelingClickedCount = x.feelingClickedCount + 1
            newFeel.feelIndex = x.feelIndex + 3
            newFeel.feelsAverage = newFeel.feelIndex/newFeel.feelingClickedCount
            newFeel.feelCount = 3
            
            feelArray.append(newFeel)
        } else {
            newFeel.feelingClickedCount = 1
            newFeel.feelIndex = 3
            newFeel.feelsAverage = newFeel.feelIndex/newFeel.feelingClickedCount
            newFeel.feelCount = 3

            feelArray.append(newFeel)
        }

        saveItems()
        updateView()
        print(feelArray)
    }
    
    @IBAction func medHappyPressed(_ sender: UIButton) {
        let newFeel = Feels(context: self.context)
        newFeel.dateEntered = Date()

        if feelArray.count != 0 {
            let x = feelArray[feelArray.count - 1]
            newFeel.feelingClickedCount = x.feelingClickedCount + 1
            newFeel.feelIndex = x.feelIndex + 4
            newFeel.feelsAverage = newFeel.feelIndex/newFeel.feelingClickedCount
            newFeel.feelCount = 4
            
            feelArray.append(newFeel)
        } else {
            newFeel.feelingClickedCount = 1
            newFeel.feelIndex = 4
            newFeel.feelsAverage = newFeel.feelIndex/newFeel.feelingClickedCount
            newFeel.feelCount = 4

            feelArray.append(newFeel)
        }

        saveItems()
        updateView()
        //if the user is happy, preform segue to happyViewController
        self.performSegue(withIdentifier: "medHappy", sender: self)
    }

    @IBAction func happyPressed(_ sender: UIButton) {
        let newFeel = Feels(context: self.context)
        newFeel.dateEntered = Date()

        if feelArray.count != 0 {
            let x = feelArray[feelArray.count - 1]
            newFeel.feelingClickedCount = x.feelingClickedCount + 1
            newFeel.feelIndex = x.feelIndex + 5
            newFeel.feelsAverage = newFeel.feelIndex/newFeel.feelingClickedCount
            newFeel.feelCount = 5
            
            feelArray.append(newFeel)
        } else {
            newFeel.feelingClickedCount = 1
            newFeel.feelIndex = 5
            newFeel.feelsAverage = newFeel.feelIndex/newFeel.feelingClickedCount
            newFeel.feelCount = 5

            feelArray.append(newFeel)
        }

        saveItems()
        updateView()
        //if the user is happy, preform segue to happyViewController
        self.performSegue(withIdentifier: "happy", sender: self)
    }
    
    func saveItems() {
         
        do {
            try context.save()
        } catch {
            print("ERROR WITH SAVINGGGGGG \(error)")
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
    
    //UPDATING THE VIEW CONTAINING THE AVERAGE FEEL AND CORRESPONDING IMAGE
    func updateView() {
        //checking that there is information in the feelArray
        if feelArray.count != 0 {
            //gathering the average
            let x = feelArray[feelArray.count - 1]
            average = x.feelsAverage
            print(average)
        } else {
            average = 0
        }

        //set image/average to a specific value based on the average feel calculated when the buttons are pressed (newFeel.feelAverage)
        if average == 0 {
            averageFeelText.text = "Enter Feels!"
            averageFeelImage.image = UIImage(named: "Happy")
        }
        if average >= 1 && average <= 2 {
            averageFeelText.text = "Not Great"
            averageFeelImage.image = UIImage(named: "Sad")
        }
        if average > 2 && average <= 3 {
            averageFeelText.text = "Alright"
            averageFeelImage.image = UIImage(named: "MEH")
        }
        if average > 3 && average <= 4 {
            averageFeelText.text = "Good!"
            averageFeelImage.image = UIImage(named: "MEDHAP")
        }
        if average > 4 && average <= 5 {
            averageFeelText.text = "Great!"
            averageFeelImage.image = UIImage(named: "Happy")
        }
    }
    
    /*func getActivity() {
        loadItems()
        if feelArray.count != 0 {
            for x in feelArray {
                if x.feelCount == 5 {
                    if x.activity != nil{
                        print("I feel level 5 happy when I: \((x.activity))")
                    }
                }
                
                if x.feelCount == 4 {
                    if x.activity != nil{
                        print("I feel level 4 happy when I: \((x.activity))")
                    }
                }
                
            }
        } else {
            print("NO INFO")
        }
    }*/
    
}
