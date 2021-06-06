//
//  statsViewController.swift
//  Zenn Path
//
//  Created by Aditya Mittal on 4/10/21.
//

import UIKit
import CoreData
class statsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
    var feelsArray = GlobalVar.globalFeels
    var happyArray = [Feels]()
    var sadArray = [Feels]()
    var arrayCount = Int()
    
    @IBOutlet weak var happyView: UIView!
    @IBOutlet weak var happyTableView: UITableView!
    @IBOutlet weak var chartsView: UIView!
    
    @IBOutlet weak var sadView: UIView!
    @IBOutlet weak var sadTableView: UITableView!
    
    @IBOutlet weak var barButton: UIButton!
    @IBOutlet weak var lineButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        print("hello!!")
        happyView.layer.cornerRadius = 15
        happyTableView.layer.cornerRadius = 15
        
        chartsView.layer.cornerRadius = 15
        
        sadView.layer.cornerRadius = 15
        sadTableView.layer.cornerRadius = 15
        
        barButton.layer.cornerRadius = 15
        lineButton.layer.cornerRadius = 15
        
        loadItems()
        
        getActivity()
        getSadActivity()
        
        print(sadArray)
        
        happyTableView.reloadData()
        sadTableView.reloadData()
        
        happyTableView.delegate = self
        happyTableView.dataSource = self
        
        sadTableView.delegate = self
        sadTableView.dataSource = self
        
        sadTableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadItems()
        
        print("hello")
        print(happyArray)
        print("SAD")
        print(sadArray)
        
        happyTableView.reloadData()
        sadTableView.reloadData()
    }

//HappyTableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1 {
            arrayCount = happyArray.count
            return arrayCount
        } else if tableView.tag == 2 {
            arrayCount = sadArray.count
            return arrayCount
        } else {
            return 0
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadItems()
        happyTableView.reloadData()
        sadTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell

        if tableView.tag == 1 {
            let item = happyArray[indexPath.row]
            cell.textLabel?.text = item.activity
        } else if tableView.tag == 2 {
            let sadItem = sadArray[indexPath.row]
            cell.textLabel?.text = sadItem.activity
        }

        return cell
    }
    
    @IBAction func barPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToBar", sender: self)
    }
    
    @IBAction func linePressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToLine", sender: self)

    }
    
    
//Get happy activites
    func getActivity() {
        if feelsArray.count != 0 {
            for x in feelsArray{
                if x.feelIndex >= 4 {
                    happyArray.append(x)
                    //print("happy activities: \(x.activity!)")
                }
            }
        }
    }
    
//Get sad activites
    func getSadActivity() {
        if feelsArray.count != 0 {
            for x in feelsArray{
                if x.feelIndex <= 3 {
                    sadArray.append(x)
                    //print("sad activities: \(x.activity!)")
                }
            }
        }
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
