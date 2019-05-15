//
//  HistoryViewController.swift
//  Journal
//
//  Created by Hai Le on 15/5/19.
//  Copyright © 2019 Hai Le. All rights reserved.
//

import UIKit
import Charts

class HistoryViewController: UIViewController {

    @IBOutlet var chartView: LineChartView!
    @IBOutlet var barChartView: BarChartView!
    @IBOutlet weak var titleButton: UIButton!
    
    var lastPeriodLength: Int = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "History"
        
        setupLineChart()
        generateLineData()
        
        setupBarChart()
        setChartData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        generateLineData()
        setChartData()
    }
    
    @IBAction func periodPressed(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Date Range", message: "Select history range", preferredStyle: .actionSheet)
        for w in DateRange.list {
            let action = UIAlertAction(title: w.string, style: .default) { (action) in
                self.lastPeriodLength = w.value
                self.titleButton.setTitle(w.string + " ", for: .normal)
                self.generateLineData()
                self.setChartData()
            }
            actionSheet.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil) //Will just dismiss the action sheet
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true, completion: nil)
    }
    
    func setupBarChart() {
        barChartView.delegate = self
        barChartView.delegate = self
        
        barChartView.chartDescription?.enabled = false
        
        barChartView.drawBarShadowEnabled = false
        barChartView.drawValueAboveBarEnabled = false
        barChartView.highlightFullBarEnabled = false
        
        let leftAxis = barChartView.leftAxis
        leftAxis.labelPosition = .outsideChart
        leftAxis.labelFont = .systemFont(ofSize: 12, weight: .medium)
        leftAxis.drawGridLinesEnabled = true
        leftAxis.granularityEnabled = true
        leftAxis.axisMinimum = 0
        leftAxis.gridLineWidth = 0.5
        leftAxis.labelTextColor = #colorLiteral(red: 0.3102914691, green: 0.3102995157, blue: 0.3102951646, alpha: 1)
        leftAxis.axisLineWidth = 1
        
        barChartView.rightAxis.enabled = false
        
        let xAxis = barChartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 12, weight: .medium)
        xAxis.labelTextColor = #colorLiteral(red: 0.3102914691, green: 0.3102995157, blue: 0.3102951646, alpha: 1)
        xAxis.drawAxisLineEnabled = true
        xAxis.drawGridLinesEnabled = false
        xAxis.centerAxisLabelsEnabled = true
        xAxis.granularity = 1
        xAxis.valueFormatter = DayFromFormatter()
        
        let l = barChartView.legend
        l.horizontalAlignment = .center
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.yEntrySpace = 5
        l.drawInside = false
        l.form = .square
        l.formToTextSpace = 4
        l.xEntrySpace = 6
    }
    
    func setChartData() {
        // Get history data from database
        let history = SQLite.shared.diaryEntryHistory(period: lastPeriodLength)
        
        let now = Date().timeIntervalSince1970
        let daySeconds: TimeInterval = 3600 * 24
        
        let from = now - (Double(lastPeriodLength) * daySeconds)
        let to = now + daySeconds
        
        var barDataEntries = [BarChartDataEntry]()
        var count = Double(-lastPeriodLength)
        for x in stride(from: from, to: to, by: daySeconds) {
            let dateStr = Date(timeIntervalSince1970: x).toDateString(withFormat: "dd-MM-yyyy")
            let object = history.filter{ $0.DateStr == dateStr }
            var yValues = [Double]()
            for i in Mood.list.map({ $0.value }) {
                if let a = object.first(where: { $0.Max == i }) {
                    yValues.append(Double(a.Count))
                } else {
                    yValues.append(0.0)
                }
            }
            print(yValues)
            
            barDataEntries.append(BarChartDataEntry(x: count, yValues: yValues))
            count += 1.0
        }
        
        
        let set = BarChartDataSet(entries: barDataEntries, label: "")
        set.drawIconsEnabled = false
        set.colors = Mood.list.map { $0.color }
        set.stackLabels = Mood.list.map { $0.description }
        
        let data = BarChartData(dataSet: set)
        data.setDrawValues(false)
        
        barChartView.fitBars = true
        barChartView.data = data
        
//        barChartView.animate(xAxisDuration: 2.0)
    }
    
    func setupLineChart() {
        chartView.delegate = self
        chartView.chartDescription?.enabled = false
        chartView.dragYEnabled = false
        chartView.dragXEnabled = true
        chartView.setScaleEnabled(false)
        chartView.pinchZoomEnabled = false
        chartView.highlightPerDragEnabled = false
        
        chartView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        chartView.legend.enabled = true
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 12, weight: .medium)
        xAxis.labelTextColor = #colorLiteral(red: 0.3102914691, green: 0.3102995157, blue: 0.3102951646, alpha: 1)
        xAxis.drawAxisLineEnabled = true
        xAxis.drawGridLinesEnabled = false
        xAxis.centerAxisLabelsEnabled = true
        xAxis.granularity = 1
        xAxis.valueFormatter = DayFromFormatter()
        
        let leftAxis = chartView.leftAxis
        leftAxis.labelPosition = .outsideChart
        leftAxis.labelFont = .systemFont(ofSize: 12, weight: .medium)
        leftAxis.drawGridLinesEnabled = true
        leftAxis.granularityEnabled = true
        leftAxis.axisMinimum = 0
        leftAxis.axisMaximum = 5.5
        leftAxis.gridLineWidth = 0.5
        leftAxis.labelTextColor = #colorLiteral(red: 0.3102914691, green: 0.3102995157, blue: 0.3102951646, alpha: 1)
        leftAxis.valueFormatter = MoodValueFormatter()
        leftAxis.axisLineWidth = 1
        
        
        chartView.rightAxis.enabled = false
        chartView.legend.form = .square
        chartView.legend.horizontalAlignment = .center
        
//        chartView.animate(xAxisDuration: 2.0)
    }
    
    func generateLineData() {
        // Get history data from database
        let history = SQLite.shared.diariesHistory(period: lastPeriodLength)
        
        let now = Date().timeIntervalSince1970
        let daySeconds: TimeInterval = 3600 * 24
        
        let from = now - (Double(lastPeriodLength) * daySeconds)
        let to = now + daySeconds
        
        // Data
        var lineDataEntries = [ChartDataEntry]()

        var count = Double(-lastPeriodLength)
        for x in stride(from: from, to: to, by: daySeconds) {
            let dateStr = Date(timeIntervalSince1970: x).toDateString(withFormat: "dd-MM-yyyy")
            let object = history.first(where: { $0.DateStr == dateStr })
            
            let avg = object?.Average ?? 0
            
            lineDataEntries.append(ChartDataEntry(x: count, y: Double(avg)))
            count += 1.0
        }
        
        // Generate line data
        let set1 = LineChartDataSet(entries: lineDataEntries, label: "Mood")
        set1.axisDependency = .left
        set1.setColor(#colorLiteral(red: 0.5568627451, green: 0.6901960784, blue: 0.1294117647, alpha: 1))
        set1.lineWidth = 2
        set1.setCircleColor(#colorLiteral(red: 0.5568627451, green: 0.6901960784, blue: 0.1294117647, alpha: 1))
        set1.drawCirclesEnabled = false
        set1.drawValuesEnabled = false
        set1.drawCircleHoleEnabled = false
        
        let lineChartData = LineChartData(dataSet: set1)
        chartView.data = lineChartData
    }
}

extension HistoryViewController: ChartViewDelegate {
    
}
