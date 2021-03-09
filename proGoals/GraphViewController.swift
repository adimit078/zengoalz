//
//  GraphViewController.swift
//  proGoals
//
//  Created by Aditya Mittal on 1/23/21.
//

import UIKit
import CoreData
import Charts
import TinyConstraints

//MAIN: DISPLAY A GRAPH OF AVERAGE FEELING INDEX OVER TIME

class GraphViewController: UIViewController, ChartViewDelegate {
    
    var feelArray = GlobalVar.meanFeel
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Feels.plist")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    lazy var lineChart: LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = .clear
        
        chartView.rightAxis.enabled = false
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.leftAxis.drawGridLinesEnabled = false
        
        let yAxis = chartView.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = .white
        yAxis.axisLineColor = .white
        yAxis.labelPosition = .outsideChart
        
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        chartView.xAxis.setLabelCount(6, force: false)
        chartView.xAxis.labelTextColor = .white
        chartView.xAxis.axisLineColor = .systemBlue
        
        chartView.animate(xAxisDuration: 1.5)
        
        return chartView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lineChart.delegate = self
        
        loadItems()
    }
    
    @IBAction func goHomePressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goBackHome", sender: self)
    }
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        
        let newFeel = Feels(context: self.context)
        
        lineChart.frame = CGRect(x: 0, y: 0,
                                width: self.view.frame.size.width,
                                height: self.view.frame.size.width)
        lineChart.center = view.center
        
        view.addSubview(lineChart)
                
        var entries = [ChartDataEntry]()
        
        for y in feelArray {
            entries.append(ChartDataEntry(x: Double(y.feelingClickedCount),y: Double(y.feelCount)))
            print("x: \(y.feelingClickedCount)")
            print("y: \(y.feelsAverage)")
        }
        
        //setData()
        let set1 = LineChartDataSet(entries: entries, label: "Your average feel over time")
        
        set1.drawCirclesEnabled = false
        set1.mode = .cubicBezier
        set1.lineWidth = 3
        set1.setColor(.white)
        set1.fill = Fill(color: .white)
        set1.fillAlpha = 0.8
        set1.drawFilledEnabled = true
        
        let data = LineChartData(dataSet: set1)
        data.setDrawValues(false)
        lineChart.data = data
    }
    
    
    func loadItems() {
        let request: NSFetchRequest<Feels> = Feels.fetchRequest()
        do {
            feelArray = try context.fetch(request)
        } catch {
            print(error)
        }
    }

}

