//
//  sadViewController.swift
//  Zenn Path
//
//  Created by Aditya Mittal on 4/10/21.
//

import UIKit
import CoreData

class sadViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let goToSadArray = [""]
    
    var feelsArray = GlobalVar.globalFeels
    var happyArray = [Feels]()
    var newIndex = String()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var strongButton: UIButton!
    
    @IBOutlet weak var activity3Input: UITextField!
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstView.layer.cornerRadius = 20
        secondView.layer.cornerRadius = 20
        
        myTableView.layer.cornerRadius = 20

        strongButton.layer.cornerRadius = 30
        
    
        self.view.backgroundColor = UIColor.darkGray
        
        
        loadItems()
        
        getActivity()
        myTableView.reloadData()
        
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    
//"I'm Strong" Pressed
    @IBAction func strongPressed(_ sender: UIButton) {
        //checking that the text box is not empty
        if (activity3Input.text != ""){
            
            //creating new instance of coreData object from the "Item" entity
            let newFeel = Feels(context: self.context)
            
            if feelsArray.count != 0 {
                let x = feelsArray[feelsArray.count-1]
                newFeel.feelCount = x.feelCount + 1
            } else {
                newFeel.feelCount = 1
            }
            
            //Logging user's happiness
            newFeel.feelIndex = Int16(newIndex) ?? 4
            
            //Logging activity1 (WHAT HAVE YOU BEEN UP TO?)
            newFeel.activity = activity3Input.text
            
            //Date Entered
            newFeel.dateEntered = Date()
            
            //Appending instance to the array containing all toDo instances
            feelsArray.append(newFeel)
            
            //Saving the str array into coreData
            self.saveItems()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
//Get happy activites
    func getActivity() {
        if feelsArray.count != 0 {
            for x in feelsArray{
                if x.feelIndex >= 4 {
                    happyArray.append(x)
                    print("happy activities: \(x.activity!)")
                }
            }
        }
    }
    
//Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return happyArray.count
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadItems()
        myTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let item = happyArray[indexPath.row]
        
        cell.textLabel?.text = item.activity
        
        return cell
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
