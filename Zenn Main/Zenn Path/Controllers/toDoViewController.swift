//
//  ToDoViewController.swift
//  Zenn Path
//
//  Created by Aditya Mittal on 4/4/21.
//

import UIKit
import CoreData

class ToDoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - OUTLET
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    
    // MARK: - PROPERTY
    var str = GlobalVar.globalToDo
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var dateCompleted = Date()
    
    
    // MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //addButton.layer.borderColor = UIColor.white.cgColor
        
        //
        //        myTableView.layer.cornerRadius = 10
        //
        //        addButton.layer.borderWidth = 4
        //        //addButton.layer.borderColor = UIColor.white.cgColor
        //        addButton.layer.cornerRadius = 20
        
        
        loadData()
        //        loadItems()
        //        myTableView.reloadData()
        //
        //        myTableView.delegate = self
        //        myTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadItems()
        myTableView.reloadData()
    }
    
    // MARK: - ALL CUSTOM FUNCTION
    func loadData() {
        
        loadItems()
        myTableView.reloadData()
        myTableView.delegate = self
        myTableView.dataSource = self
        
    }
    
    
    // MARK: - SEGUE METHOD FOR NAVIGATION
    @IBAction func unwindToOne (_ sender: UIStoryboardSegue){}
    
    
    //MARK:- UITableView DELEGATE METHOD
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return str.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let item = str[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.textLabel?.font = UIFont(name: "Futura", size: 15.0)
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        cell.imageView?.image = UIImage(named: "none")
        
        switch item.priority {
        case 0:
            cell.imageView?.image = UIImage(named: "none")
        case 1:
            cell.imageView?.image = UIImage(named: "low")
        case 2:
            cell.imageView?.image = UIImage(named: "medium")
        case 3:
            cell.imageView?.image = UIImage(named: "high")
        default:
            print("sdsddsf")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = str[indexPath.row]
        //item.done = !item.done
        var priority = String()
        var size = String()
        
        if item.priority == 0 {priority = "None"}
        else if item.priority == 1 {priority = "Low"}
        else if item.priority == 2 {priority = "Medium"}
        else if item.priority == 3 {priority = "High"}
        
        if item.size == 0 {priority = "Extra Small"}
        else if item.size == 1 {size = "Small"}
        else if item.size == 2 {size = "Medium"}
        else if item.size == 3 {size = "Large"}
        else if item.size == 4 {size = "Extra Large"}
        
        //        let newItem = Item(context: self.context)
        //        dateCompleted = Date()
        //        print("The date you have completed: \(str[indexPath.row])     \(dateCompleted)")
        //        newItem.dateCompleted = dateCompleted
        
        saveItems()
        
        //tableView.deselectRow(at: indexPath, animated: true)
        
        myTableView.reloadData()
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM d, h:mm a"
        let datePretty = dateFormatterPrint.string(from: item.dueDate!)
        
        let alert = UIAlertController(title: "ToDo: \(item.title!)", message: "Due Date: \(datePretty) \nSize: \(size) \nPriority Level: \(priority)", preferredStyle: UIAlertController.Style.alert)
        alert.setTitlet(font: UIFont(name: "Futura", size: 20.0), color: .black)
        alert.setMessage(font: UIFont(name: "Futura", size: 15.0), color: .black)
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete{
            
            context.delete(str[indexPath.row])
            self.str.remove(at: indexPath.row)
            
            self.saveItems()
            loadItems()
            
            myTableView.reloadData()
        }
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
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
        request.returnsObjectsAsFaults = false
        do {
            str = try context.fetch(request)
        } catch {
            "error fetching data"
        }
    }
    
    
    
}

