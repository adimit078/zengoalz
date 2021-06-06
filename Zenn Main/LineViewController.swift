//
//  LineViewController.swift
//  Zenn Path
//
//  Created by Aditya Mittal on 5/4/21.
//

import UIKit
import Charts
import CoreData

class LineViewController: UIViewController, ChartViewDelegate {
    
    var lineChart = LineChartView()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var feelsArray = GlobalVar.globalFeels
    let entry1 = Double()

    
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var dateOutput: UILabel!
    @IBOutlet weak var feelingOutput: UILabel!
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var reasonOutput: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lineChart.delegate = self
        
        infoView.layer.cornerRadius = 20
        chartView.layer.cornerRadius = 20
        
        loadItems()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        lineChart.frame = CGRect(x: 24, y: 182, width: 360, height: 340)
        //lineChart.center = view.center
        
        lineChart.rightAxis.enabled = false
        lineChart.legend.enabled = false
        
        let yAxis = lineChart.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.axisMinimum = 0
        yAxis.axisMaximum = 7
        yAxis.setLabelCount(6, force: true)
        yAxis.labelTextColor = .white
        yAxis.axisLineColor = .white
        
        
        lineChart.xAxis.labelPosition = .bottom
        lineChart.xAxis.labelTextColor = .white
        lineChart.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        lineChart.xAxis.axisLineColor = .white
        
        lineChart.animate(xAxisDuration: 1)
        
        view.addSubview(lineChart)
        
        var entries = [ChartDataEntry]()
        
        for x in feelsArray {
            entries.append(ChartDataEntry(x: Double((x.feelCount)), y: Double((x.feelIndex))))
        }
        
        let set = LineChartDataSet(entries: entries, label: "Mood Over Time")
        set.drawCirclesEnabled = true
        set.circleHoleColor = .white
        set.setCircleColor(.orange)
        set.lineWidth = 5
        set.setColor(.white)
        set.fill = Fill(color: .white)
        set.fillAlpha = 0.4
        set.mode = .cubicBezier
        set.drawFilledEnabled = true
        set.highlightColor = .orange
        
        let data = LineChartData(dataSet: set)
        data.setDrawValues(false)
        
        lineChart.data = data
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        let feelCount = entry.x
        print(feelsArray.count)
        let feelCurrent = (feelsArray[Int(feelCount)-1])
        let dateEntered = feelCurrent.dateEntered
        var feelIndex  = feelCurrent.feelIndex
        var feelActivity = feelCurrent.activity
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM d, h:mm a"
        
        let datePretty = dateFormatterPrint.string(from: dateEntered!)
        
        dateOutput.text = datePretty
        
        if feelIndex == 1 {feelingOutput.text = "Very Sad"}
        else if feelIndex == 2 {feelingOutput.text = "Sad"}
        else if feelIndex == 3 {feelingOutput.text = "Unsure"}
        else if feelIndex == 4 {feelingOutput.text = "Content"}
        else if feelIndex == 5 {feelingOutput.text = "Happy"}
        else if feelIndex == 6 {feelingOutput.text = "Very Happy"}
        
        reasonOutput.text = feelActivity
        
        print("On \(datePretty), you felt like a: \(feelIndex) ---- (\(Int(feelCount)-1),\(feelIndex))")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
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
