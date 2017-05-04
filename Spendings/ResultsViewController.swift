//
//  ResultsViewController.swift
//  Spendings
//
//  Copyright © 2017 Козлов Егор. All rights reserved.
//

import UIKit
import Charts
import RealmSwift

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let statBrain = StatisticsBrain()

    var data = [(type: String, sum: Double)]()
    
    @IBOutlet weak var pieChartView: PieChartView! {
        didSet {
            pieChartView.drawHoleEnabled = true
            pieChartView.rotationEnabled = false
            pieChartView.rotationWithTwoFingers = true
            pieChartView.usePercentValuesEnabled = true
            pieChartView.drawSliceTextEnabled = false
            pieChartView.descriptionText = "Расходы за период"
            pieChartView.descriptionTextColor = UIColor.white
            self.pieChartView.legend.wordWrapEnabled = true
            
            if data.count > 8 {
                self.pieChartView.legend.position = .belowChartRight
            } else {
                self.pieChartView.legend.position = .piechartCenter
            }
        }
    }

    @IBOutlet weak var horisontalBarChartView: HorizontalBarChartView! {
        didSet {
            horisontalBarChartView.descriptionText = "Расходы за период"
            horisontalBarChartView.descriptionTextColor = UIColor.white
            horisontalBarChartView.legend.enabled = false
            horisontalBarChartView.leftAxis.enabled = false
            horisontalBarChartView.rightAxis.enabled = false
            
            horisontalBarChartView.xAxis.drawGridLinesEnabled = false
            horisontalBarChartView.xAxis.labelPosition = .bottom
            horisontalBarChartView.xAxis.labelTextColor = UIColor.white
        }
    }
    
    fileprivate let colors : [UIColor] = {
        var tmp = [UIColor]()
        tmp.append(contentsOf: ChartColorTemplates.pastel())
        tmp.append(contentsOf: ChartColorTemplates.joyful())
        tmp.append(contentsOf: ChartColorTemplates.liberty())
        tmp.append(contentsOf: ChartColorTemplates.vordiplom())
        tmp.append(contentsOf: ChartColorTemplates.colorful())
        return tmp
    }()
    
    func setPieChartData(_ yVals: [BarChartDataEntry], xVals: [String?]) {
        let dataSet = PieChartDataSet(values: yVals, label: nil)
        
        dataSet.colors = colors
        let data = PieChartData(dataSet: dataSet)
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.multiplier = 1
        formatter.maximumFractionDigits = 1
        data.setValueFormatter(formatter as! IValueFormatter)
        data.setValueFont(UIFont.preferredFont(forTextStyle: UIFontTextStyle.caption2))
        self.pieChartView.data = data
        pieChartView.animate(xAxisDuration: 1.4, easingOption: .easeOutBack)
    }
    
    func setHorisontalBarChartData(_ yVals: [BarChartDataEntry], xVals: [String?]) {
        let dataSet = BarChartDataSet(values: yVals, label: nil)
        dataSet.colors = colors
        let data = BarChartData(dataSet: dataSet)
        data.setValueTextColor(UIColor.white)
        horisontalBarChartView.data = data
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData(0)
    }
    
    func setData(_ selection: Int) {
        let date = Date()
        
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter
        }()

        var type: PeriodType = .day
        
        switch selection {
        case 0:
            break
        case 1:
            dateFormatter.dateFormat = "LLLL yyyy"
            type = .month
            break
        case 2:
            dateFormatter.dateFormat = "yyyy"
            type =  .year
            break
        default:
            break
        }
        self.title = dateFormatter.string(from: date)
        
        var yVals = [BarChartDataEntry]()
        var xVals = [String?]()
        
        self.data = statBrain.getStatistics(type)
        
        for (index, object) in data.enumerated() {
            yVals.append(BarChartDataEntry(x: Double(index), y: object.sum))
            xVals.append(object.type)
        }
        setPieChartData(yVals, xVals: xVals)
        setHorisontalBarChartData(yVals, xVals: xVals)
    }
    @IBAction func toggleMenu(_ sender: UIBarButtonItem) {
        toggleSideMenuView()
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        setData(sender.selectedSegmentIndex)
    }
}

extension ResultsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1
        self.pageControl.currentPage = Int(page)
    }
}
