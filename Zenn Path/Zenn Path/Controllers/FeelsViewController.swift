//
//  FeelsViewController.swift
//  Zenn Path
//
//  Created by Aditya Mittal on 4/4/21.
//

import UIKit

class FeelsViewController: UIViewController {

    @IBOutlet weak var xHappyView: UIView!
    @IBOutlet weak var happyView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var unsureView: UIView!
    @IBOutlet weak var sadView: UIView!
    @IBOutlet weak var xSadView: UIView!

    var feelIndex = GlobalVar.globalFeelIndex
    var text: String = ""
    
    var initialIndex: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        xHappyView.layer.cornerRadius = 40
        happyView.layer.cornerRadius = 40
        contentView.layer.cornerRadius = 40
        unsureView.layer.cornerRadius = 40
        sadView.layer.cornerRadius = 40
        xSadView.layer.cornerRadius = 40
    }

    @IBAction func xHappy(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToHappy6", sender: self)
    }
    
    @IBAction func happyPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToHappy5", sender: self)
    }
    
    @IBAction func contentPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToHappy4", sender: self)
    }
    
    @IBAction func unsurePressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToHappy3", sender: self)
    }
    
    @IBAction func sadPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToHappy2", sender: self)
    }
    
    @IBAction func xSadPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToHappy1", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToHappy6"){
                let displayVC = segue.destination as! happyViewController
                displayVC.newIndex = "6"
        }
        if(segue.identifier == "goToHappy5"){
                let displayVC = segue.destination as! happyViewController
                displayVC.newIndex = "5"
        }
        if(segue.identifier == "goToHappy4"){
                let displayVC = segue.destination as! happyViewController
                displayVC.newIndex = "4"
        }
        if(segue.identifier == "goToHappy3"){
                let displayVC = segue.destination as! happyViewController
                displayVC.newIndex = "3"
        }
        if(segue.identifier == "goToHappy2"){
                let displayVC = segue.destination as! happyViewController
                displayVC.newIndex = "2"
        }
        if(segue.identifier == "goToHappy1"){
                let displayVC = segue.destination as! happyViewController
                displayVC.newIndex = "1"
        }
    }
    
}
