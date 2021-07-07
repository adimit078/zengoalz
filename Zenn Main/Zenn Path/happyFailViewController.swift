//
//  HappyFailViewController.swift
//  Zenn Path
//
//  Created by Aditya Mittal on 4/9/21.
//

import UIKit
import CoreData

class HappyFailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    // MARK: - OUTLET
    @IBOutlet weak var bigView: UIView!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var goButton: UIButton!
    
    // MARK: - PROPERTY
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var itemArray = GlobalVar.globalToDo
    var smallToDoArray = [Item]()
    
    
    // MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
//        loadItems()
//
//        myTableView.reloadData()
//        getActivity()
//
//        myTableView.delegate = self
//        myTableView.dataSource = self
//
//        bigView.layer.cornerRadius = 20
//        myTableView.layer.cornerRadius = 20
//        goButton.layer.cornerRadius = 30
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadItems()
        myTableView.reloadData()
    }
    
    
    // MARK: - ALL CUSTOM FUNCTION
    func loadData()
    {
        loadItems()
        
        myTableView.reloadData()
        getActivity()
        
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    
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
    
    func loadItems() {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        do {
            itemArray = try context.fetch(request)
        } catch {
            "error fetching data"
        }
    }
    
    //MARK:- UITableView DELEGATE METHOD
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return smallToDoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let item = smallToDoArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        cell.textLabel?.font = UIFont(name: "Futura", size: 15.0)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    
}
