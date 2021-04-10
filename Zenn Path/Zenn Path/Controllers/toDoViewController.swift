//
//  toDoViewController.swift
//  Zenn Path
//
//  Created by Aditya Mittal on 4/4/21.
//

import UIKit
import CoreData

class toDoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    var str = GlobalVar.globalToDo
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var dateCompleted = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.layer.cornerRadius = 10
        
        addButton.layer.borderWidth = 2
        addButton.layer.borderColor = UIColor.white.cgColor
        addButton.layer.cornerRadius = 20
        
        loadItems()
        myTableView.reloadData()
        
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    
//Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return str.count
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadItems()
        myTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let item = str[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        str[indexPath.row].done = !str[indexPath.row].done

        let newItem = Item(context: self.context)
        dateCompleted = Date()
        print("The date you have completed: \(str[indexPath.row])     \(dateCompleted)")
        newItem.dateCompleted = dateCompleted

        saveItems()

        tableView.deselectRow(at: indexPath, animated: true)
        
        myTableView.reloadData()
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
    
//Save Items
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
    
    @IBAction func unwindToOne (_ sender: UIStoryboardSegue){}

}

