// CHANGE TESTTTTTTTT (3/8)



//  ViewController.swift
//  proGoals
//
//  Created by Aditya Mittal on 12/12/20.
//

import UIKit
import QuartzCore

//MAIN: MAIN HOME SCREEN PROVIDING UPLIFTING QUOTE AND BUTTONS TO REDIRECT TO DIFFERENT SCREENS

//Create the basic arrays and quote list that will be used throughout the app (list of ToDos, array of feeling properties, quotes, etc.)
struct GlobalVar {
    static var globalToDo = [Item]()
    static var meanFeel = [Feels]()
    static var activArray = [String]()
    static var quoteArray = ["Without a humble but reasonable confidence in your own powers you cannot be successful or happy. —Norman Vincent Peale", "If you can dream it, you can do it. —Walt Disney","Press Forward","Just keep breathing.","The future belongs to those who believe in the beauty of their dreams. -Eleanor Roosevelt","Aim for the moon, if you miss, you may hit a star.","Fear no one, but respect everyone. -Roger Federer"]
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var toDo: UIButton!
    @IBOutlet weak var feels: UIButton!
    @IBOutlet weak var progress: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Beautification of app buttons
        toDo.layer.cornerRadius = 20
        toDo.layer.borderWidth = 1
        toDo.layer.borderColor = UIColor.white.cgColor

        feels.layer.cornerRadius = 20
        feels.layer.borderWidth = 1
        feels.layer.borderColor = UIColor.white.cgColor
        
        progress.layer.cornerRadius = 20
        progress.layer.borderWidth = 1
        progress.layer.borderColor = UIColor.white.cgColor
        
        quoteLabel.layer.cornerRadius = 20
        
        //Setting the quote on the homepage to be random element in the quoteArray
        let quoteHome = GlobalVar.quoteArray
        quoteLabel.text = quoteHome.randomElement()
    }

    //Activating the buttons and preforming segues to various different screens
    @IBAction func toDoPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "goToToDo", sender: self)
    }

    @IBAction func feelsPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "goFeels", sender: self)
    }
    
    @IBAction func progressPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "goToGraph", sender: self)
    }
    
}

