//
//  happyFailViewController.swift
//  Zenn Path
//
//  Created by Aditya Mittal on 4/9/21.
//

import UIKit
import CoreData

class happyFailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var itemArray = GlobalVar.globalToDo
    var smallToDoArray = [Item]()
    
    @IBOutlet weak var bigView: UIView!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var goButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bigView.layer.cornerRadius = 20
        myTableView.layer.cornerRadius = 20
        goButton.layer.cornerRadius = 30

        loadItems()
        
        myTableView.reloadData()
        getActivity()
        
        myTableView.delegate = self
        myTableView.dataSource = self
    }

//Get SMALL TODOs
    func getActivity() {
        print("Item array: \(itemArray)")
        if itemArray.count != 0 {
            for x in itemArray{
                if x.size <= 1 {
                    print("Activity: \(x.title!), Size: \(x.size)")
                    smallToDoArray.append(x)
                }
            }
        }
    }
    
//Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return smallToDoArray.count
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadItems()
        myTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let item = smallToDoArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none

        return cell
    }

//Load Items
    func loadItems() {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        do {
            itemArray = try context.fetch(request)
        } catch {
            "error fetching data"
        }
    }
    
    
    
}
