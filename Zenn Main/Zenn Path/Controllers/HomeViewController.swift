//
//  HomeViewController.swift
//  Zenn Path
//
//  Created by Aditya Mittal on 4/4/21.
//

import UIKit
import QuartzCore


class HomeViewController: UIViewController {
    
    
    //MARK:- OUTELET
    @IBOutlet weak var homeButton: UITabBarItem!
    @IBOutlet weak var quoteView: UILabel!
    
    //MARK: PROPERTY
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    //MARK: LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        let quoteHome = GlobalVar.quoteArray
        //        quoteView.text = quoteHome.randomElement()
        //
        //        print(dataFilePath)
        loadData()
    }
    
   
    //MARK:- ALL IBACTION METHOD
    @IBAction func unwindToHome(_ sender: UIStoryboardSegue){}
    @IBAction func unwindToHomeFromSad(_ sender: UIStoryboardSegue){}
    @IBAction func undwindFromToDo(_sender: UIStoryboardSegue){}
    
    //MARK:- ALL CUSTOM FUNCTION
    func loadData() {
        let quoteHome = GlobalVar.quoteArray
        quoteView.text = quoteHome.randomElement()
        print(dataFilePath)
    }
    
    
    
}
