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
    
    let barchart = BarChartView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        barchart.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        barchart.frame = CGRect(x: 10, y: 10, width: 400, height: 500)
        barchart.center = view.center
        view.addSubview(barchart)
        
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
