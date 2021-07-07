//
//  BarViewController.swift
//  Zenn Path
//
//  Created by Aditya Mittal on 5/4/21.
//

import UIKit
import CoreData
import Charts

class BarViewController: UIViewController, ChartViewDelegate {
    
    // MARK: - OUTLET
    @IBOutlet weak var VW: UIView!
    
    
    // MARK: - PROPERTY
    let barchart = BarChartView()
    
    
    // MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        barchart.delegate = self
    }
    
    
    // MARK: - UI SETUP
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //        barchart.frame = CGRect(x: 10, y: 10, width: 370, height: 470)
        barchart.frame = CGRect(x: 30, y: 20, width: 360, height: 390)
        //        barchart.center = view.center
        //        view.addSubview(barchart)
        VW.addSubview(barchart)
        
        var entries = [BarChartDataEntry]()
        
        for x in 0..<10 {
            entries.append(BarChartDataEntry(x: Double(x), y: Double(x)))
        }
        
        let set = BarChartDataSet(entries: entries)
        
        set.colors = ChartColorTemplates.joyful()
        
        let data = BarChartData(dataSet: set)
        
        barchart.data = data
    }
    
}
