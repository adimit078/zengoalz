//
//  HomeViewController.swift
//  Zenn Path
//
//  Created by Aditya Mittal on 4/4/21.
//

import UIKit
import QuartzCore

struct GlobalVar {
    static var activArray = [String]()
    static var priorityLevel = Int()
    static var dueDate = Date()
    static var size = Int()
    static var item = (Item)()
    static var globalToDo = [Item]()
    static var globalFeels = [Feels]()
    static var globalFeelIndex = Int()
    
    static var quoteArray = ["Without a humble but reasonable confidence in your own powers you cannot be successful or happy. —Norman Vincent Peale", "If you can dream it, you can do it. —Walt Disney","Press Forward, you got this","Just keep breathing.","The future belongs to those who believe in the beauty of their dreams. -Eleanor Roosevelt","Aim for the moon, if you miss, you may hit a star.","Fear no one, but respect everyone. -Roger Federer"]
}

class HomeViewController: UIViewController {
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

    @IBOutlet weak var homeButton: UITabBarItem!
    @IBOutlet weak var quoteView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let quoteHome = GlobalVar.quoteArray
        quoteView.text = quoteHome.randomElement()
        
        print(dataFilePath)
    }
    
    @IBAction func unwindToHome(_ sender: UIStoryboardSegue){}
    @IBAction func unwindToHomeFromSad(_ sender: UIStoryboardSegue){}
    @IBAction func undwindFromToDo(_sender: UIStoryboardSegue){}

    
}
