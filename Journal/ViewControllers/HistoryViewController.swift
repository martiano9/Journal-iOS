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
    @IBOutlet var sliderX: UISlider!
    @IBOutlet var sliderTextX: UITextField!
    var lastPeriodLength: Int = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "History"
        
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
        xAxis.labelTextColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
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
        leftAxis.labelTextColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        leftAxis.valueFormatter = MoodValueFormatter()


        chartView.rightAxis.enabled = false
        chartView.legend.form = .square

        chartView.animate(xAxisDuration: 2.0)
        
        generateCombinedData()
    }
    
    func generateCombinedData() {
        // Get history data from database
        let history = SQLite.shared.diariesHistory()
        
        let now = Date().timeIntervalSince1970
        let daySeconds: TimeInterval = 3600 * 24
        
        let from = now - (Double(lastPeriodLength) * daySeconds)
        let to = now + daySeconds * 2
        
        // Data
        var lineDataEntries = [ChartDataEntry]()
        var barDataEntries = [BarChartDataEntry]()
        for x in stride(from: from, to: to, by: daySeconds) {
            let dateStr = Date(timeIntervalSince1970: x).toDateString(withFormat: "dd-MM-yyyy")
            let object = history.first(where: { $0.DateStr == dateStr })
            
            let avg = object?.Average ?? 0
            let count = object?.Count ?? 0
            
            lineDataEntries.append(ChartDataEntry(x: x, y: Double(avg)))
            barDataEntries.append(BarChartDataEntry(x: x, y: Double(count)))
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
