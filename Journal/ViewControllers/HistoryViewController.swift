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
    
    var lastPeriodLength: Int = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "History"
        
        setupLineChart()
        generateLineData()
        
        setupBarChart()
        setChartData(count: 30, range: 100)
    }
    
    func setupBarChart() {
        barChartView.delegate = self
        barChartView.delegate = self
        
        barChartView.chartDescription?.enabled = false
        
        barChartView.drawBarShadowEnabled = false
        barChartView.drawValueAboveBarEnabled = false
        barChartView.highlightFullBarEnabled = false
        
        let leftAxis = barChartView.leftAxis
        leftAxis.axisMinimum = 0
        leftAxis.granularityEnabled = true
        leftAxis.granularity = 1.0
        leftAxis.labelTextColor = #colorLiteral(red: 0.3102914691, green: 0.3102995157, blue: 0.3102951646, alpha: 1)
        leftAxis.labelFont = .systemFont(ofSize: 12, weight: .medium)
        leftAxis.gridLineWidth = 0.5
        
        
        barChartView.rightAxis.enabled = false
        
        let xAxis = barChartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.valueFormatter = DateValueFormatter()
        xAxis.drawLabelsEnabled = false
        xAxis.drawGridLinesEnabled = false
        xAxis.labelFont = .systemFont(ofSize: 12, weight: .medium)
        xAxis.labelTextColor = #colorLiteral(red: 0.3102914691, green: 0.3102995157, blue: 0.3102951646, alpha: 1)
        
        let l = barChartView.legend
        l.horizontalAlignment = .center
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = false
        l.form = .square
        l.formToTextSpace = 4
        l.xEntrySpace = 6
    }
    
    func setChartData(count: Int, range: UInt32) {
        // Get history data from database
        let history = SQLite.shared.diaryEntryHistory()
        
        let now = Date().timeIntervalSince1970
        let daySeconds: TimeInterval = 3600 * 24
        
        let from = now - (Double(lastPeriodLength) * daySeconds)
        let to = now + daySeconds * 2
        
        var barDataEntries = [BarChartDataEntry]()
        var count = 0.0
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
        data.setValueFont(.systemFont(ofSize: 7, weight: .light))
        data.setValueTextColor(.white)
        data.setDrawValues(false)
        
        barChartView.fitBars = true
        barChartView.data = data
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
        xAxis.valueFormatter = DateValueFormatter()
        
        let leftAxis = chartView.leftAxis
        leftAxis.labelPosition = .outsideChart
        leftAxis.labelFont = .systemFont(ofSize: 12, weight: .medium)
        leftAxis.drawGridLinesEnabled = true
        leftAxis.granularityEnabled = true
        leftAxis.axisMinimum = 0
        leftAxis.axisMaximum = 5.5
        leftAxis.gridLineWidth = 0.5
        leftAxis.yOffset = 0
        leftAxis.labelTextColor = #colorLiteral(red: 0.3102914691, green: 0.3102995157, blue: 0.3102951646, alpha: 1)
        leftAxis.valueFormatter = MoodValueFormatter()
        
        
        chartView.rightAxis.enabled = false
        chartView.legend.form = .square
        chartView.legend.horizontalAlignment = .center
        
        chartView.animate(xAxisDuration: 2.0)
    }
    
    func generateLineData() {
        // Get history data from database
        let history = SQLite.shared.diariesHistory()
        
        let now = Date().timeIntervalSince1970
        let daySeconds: TimeInterval = 3600 * 24
        
        let from = now - (Double(lastPeriodLength) * daySeconds)
        let to = now + daySeconds * 2
        
        // Data
        var lineDataEntries = [ChartDataEntry]()

        for x in stride(from: from, to: to, by: daySeconds) {
            let dateStr = Date(timeIntervalSince1970: x).toDateString(withFormat: "dd-MM-yyyy")
            let object = history.first(where: { $0.DateStr == dateStr })
            
            let avg = object?.Average ?? 0
            
            lineDataEntries.append(ChartDataEntry(x: x, y: Double(avg)))
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
