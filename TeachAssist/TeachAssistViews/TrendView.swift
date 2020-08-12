//
//  TrendView.swift
//  TeachAssist
//
//  Created by York Wei on 2020-03-25.
//  Copyright © 2020 York Wei. All rights reserved.
//

import SwiftUI
import Charts

struct TrendView: View {
    
    private let averageProgression : [Double]
    private let kProgression : [Double]
    private let tProgression : [Double]
    private let cProgression : [Double]
    private let aProgression : [Double]
    
    init(course: Course) {
        
        var averageProgression = [Double]()
        
        //get all the category trends
        var kProgression = [Double]()
        var tProgression = [Double]()
        var cProgression = [Double]()
        var aProgression = [Double]()
        
        var kSum = 0.0
        var kWeightSum = 0.0
        var tSum = 0.0
        var tWeightSum = 0.0
        var cSum = 0.0
        var cWeightSum = 0.0
        var aSum = 0.0
        var aWeightSum = 0.0
        var oSum = 0.0
        var oWeightSum = 0.0
        var fSum = 0.0
        var fWeightSum = 0.0
        
        
        for evaluation in course.evaluations {
            
            var kAverage = -1.0
            var tAverage = -1.0
            var cAverage = -1.0
            var aAverage = -1.0
            var oAverage = -1.0
            var fAverage = -1.0
            
            if evaluation.knowledge.percent != -1 && evaluation.knowledge.weight > 0 {
                kSum += evaluation.knowledge.percent * evaluation.knowledge.weight
                kWeightSum += evaluation.knowledge.weight
                kProgression.append(kSum / kWeightSum)
            }
            if(kWeightSum != 0) {
                kAverage = kSum / kWeightSum
            }
            
            if evaluation.thinking.percent != -1 && evaluation.thinking.weight > 0 {
                tSum += evaluation.thinking.percent * evaluation.thinking.weight
                tWeightSum += evaluation.thinking.weight
                tProgression.append(tSum / tWeightSum)
            }
            if(tWeightSum != 0) {
                tAverage = tSum / tWeightSum
            }
            
            if evaluation.communication.percent != -1 && evaluation.communication.weight > 0 {
                cSum += evaluation.communication.percent * evaluation.communication.weight
                cWeightSum += evaluation.communication.weight
                cProgression.append(cSum / cWeightSum)
            }
            if(cWeightSum != 0) {
                cAverage = cSum / cWeightSum
            }
            
            if evaluation.application.percent != -1 && evaluation.application.weight > 0 {
                aSum += evaluation.application.percent * evaluation.application.weight
                aWeightSum += evaluation.application.weight
                aProgression.append(aSum / aWeightSum)
            }
            if(aWeightSum != 0) {
                aAverage = aSum / aWeightSum
            }
            
            if evaluation.other.percent != -1 && evaluation.other.weight > 0 {
                oSum += evaluation.other.percent * evaluation.other.weight
                oWeightSum += evaluation.other.weight
                oAverage = oSum / oWeightSum
            }
            if(oWeightSum != 0) {
                oAverage = oSum / oWeightSum
            }
            
            if evaluation.finals.percent != -1 && evaluation.finals.weight > 0 {
                fSum += evaluation.finals.percent * evaluation.finals.weight
                fWeightSum += evaluation.finals.weight
                fAverage = fSum / fWeightSum
            }
            if(fWeightSum != 0) {
                fAverage = fSum / fWeightSum
            }
            
            var kCourseWeight = course.knowledge.weight
            var tCourseWeight = course.thinking.weight
            var cCourseWeight = course.communication.weight
            var aCourseWeight = course.application.weight
            var oCourseWeight = course.other.weight
            var fCourseWeight = course.finals.weight
            
            if kWeightSum == 0 || kAverage == -1 {
                kCourseWeight = 0
            }
            if tWeightSum == 0 || tAverage == -1 {
                tCourseWeight = 0
            }
            if cWeightSum == 0 || cAverage == -1 {
                cCourseWeight = 0
            }
            if aWeightSum == 0 || aAverage == -1 {
                aCourseWeight = 0
            }
            if oWeightSum == 0 || oAverage == -1 {
                oCourseWeight = 0
            }
            if fWeightSum == 0 || fAverage == -1 {
                fCourseWeight = 0
            }

            if(kCourseWeight + tCourseWeight + cCourseWeight + aCourseWeight + oCourseWeight + fCourseWeight != 0) {
                averageProgression.append( ((kAverage*kCourseWeight) + (tAverage*tCourseWeight) + (cAverage*cCourseWeight) + (aAverage*aCourseWeight) + (oAverage*oCourseWeight) + (fAverage*fCourseWeight)) / (kCourseWeight + tCourseWeight + cCourseWeight + aCourseWeight + oCourseWeight + fCourseWeight) )
                
//                print(((kAverage*kCourseWeight) + (tAverage*tCourseWeight) + (cAverage*cCourseWeight) + (aAverage*aCourseWeight) + (oAverage*oCourseWeight)) / (kCourseWeight + tCourseWeight + cCourseWeight + aCourseWeight + oCourseWeight))
            }
        }
        
        self.kProgression = kProgression
        self.tProgression = tProgression
        self.cProgression = cProgression
        self.aProgression = aProgression
        self.averageProgression = averageProgression
        
    }
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            ZStack (alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color("CellColor"))
                    .frame(height: 260)
                    .cornerRadius(20)
                    .shadow(color: Color("DropShadowColor"), radius: 5, x: 0, y: 3)
                VStack (alignment: .leading) {
                    Text("Course Average")
                        .foregroundColor(Color("SecondaryTextColor"))
                        .font(.system(size: get(type: "small"), weight: .semibold))
                        .padding(.leading, 25)
                        .padding(.top, 10)
                    LineChartSwiftUI(data: self.averageProgression)
                        .frame(height: 180)
                        .padding(.trailing, 20)
                        .padding(.leading, 20)
                }
            }
            
            ZStack (alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color("CellColor"))
                    .frame(height: 260)
                    .cornerRadius(20)
                    .shadow(color: Color("DropShadowColor"), radius: 5, x: 0, y: 3)
                VStack (alignment: .leading) {
                    Text("Knowledge")
                        .foregroundColor(Color("SecondaryTextColor"))
                        .font(.system(size: get(type: "small"), weight: .semibold))
                        .padding(.leading, 25)
                        .padding(.top, 10)
                    LineChartSwiftUI(data: self.kProgression)
                        .frame(height: 180)
                        .padding(.trailing, 20)
                        .padding(.leading, 20)
                }
            }
            
            ZStack (alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color("CellColor"))
                    .frame(height: 260)
                    .cornerRadius(20)
                    .shadow(color: Color("DropShadowColor"), radius: 5, x: 0, y: 3)
                VStack (alignment: .leading) {
                    Text("Thinking")
                        .foregroundColor(Color("SecondaryTextColor"))
                        .font(.system(size: get(type: "small"), weight: .semibold))
                        .padding(.leading, 25)
                        .padding(.top, 10)
                    LineChartSwiftUI(data: self.tProgression)
                        .frame(height: 180)
                        .padding(.trailing, 20)
                        .padding(.leading, 20)
                }
            }
            
            ZStack (alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color("CellColor"))
                    .frame(height: 260)
                    .cornerRadius(20)
                    .shadow(color: Color("DropShadowColor"), radius: 5, x: 0, y: 3)
                VStack (alignment: .leading) {
                    Text("Communication")
                        .foregroundColor(Color("SecondaryTextColor"))
                        .font(.system(size: get(type: "small"), weight: .semibold))
                        .padding(.leading, 25)
                        .padding(.top, 10)
                    LineChartSwiftUI(data: self.cProgression)
                        .frame(height: 180)
                        .padding(.trailing, 20)
                        .padding(.leading, 20)
                }
            }
            
            ZStack (alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color("CellColor"))
                    .frame(height: 260)
                    .cornerRadius(20)
                    .shadow(color: Color("DropShadowColor"), radius: 5, x: 0, y: 3)
                VStack (alignment: .leading) {
                    Text("Application")
                        .foregroundColor(Color("SecondaryTextColor"))
                        .font(.system(size: get(type: "small"), weight: .semibold))
                        .padding(.leading, 25)
                        .padding(.top, 10)
                    LineChartSwiftUI(data: self.aProgression)
                        .frame(height: 180)
                        .padding(.trailing, 20)
                        .padding(.leading, 20)
                }
            }
            
        }
        
    }
    
}

struct LineChartSwiftUI: UIViewRepresentable {
    
    private let data: [Double]
    private var dataEntry = [ChartDataEntry]()
    
    init(data: [Double]) {
        self.data = data
        for (i, mark) in data.enumerated() {
            let value = ChartDataEntry(x: Double(i), y: mark)
            dataEntry.append(value)
        }
    }
    
    let lineChart = LineChartView()
    
    func makeUIView(context: UIViewRepresentableContext<LineChartSwiftUI>) -> LineChartView {
        lineChart.noDataText = "No Data Available"
        let line = LineChartDataSet(entries: dataEntry, label: "")
        let data = LineChartData()
        
        line.colors = [UIColor(named: "IconColor")!]
        line.lineWidth = 3
        line.circleColors = [UIColor(named: "IconColor")!]
        line.circleRadius = 5
        line.drawCirclesEnabled = false
        line.drawCircleHoleEnabled = false
        line.mode = .horizontalBezier
        let gradientColors = [UIColor(named: "IconColor")!.cgColor, UIColor.clear.cgColor] as CFArray // Colors of the gradient
        let colorLocations:[CGFloat] = [0.8, 0.0] // Positioning of the gradient
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) // Gradient Object
        line.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0) // Set the Gradient
        line.drawFilledEnabled = true // Draw the Gradient
        
        data.addDataSet(line)
        data.setDrawValues(false)
        
        lineChart.xAxis.enabled = false
        lineChart.leftAxis.axisMinimum = 50
        lineChart.leftAxis.axisMaximum = 105
        lineChart.leftAxis.gridColor = UIColor(named: "SecondaryTextColor")!
        lineChart.leftAxis.drawGridLinesEnabled = true
        lineChart.leftAxis.gridLineWidth = 0.1
        lineChart.leftAxis.labelTextColor = UIColor(named: "SecondaryTextColor")!
        lineChart.leftAxis.axisLineColor = UIColor(named: "SecondaryTextColor")!
        lineChart.rightAxis.enabled = false
        lineChart.legend.enabled = false
        lineChart.isUserInteractionEnabled = false
        lineChart.data = data
        lineChart.backgroundColor = UIColor(named: "CellColor")
        
        return lineChart
    }
    
    func updateUIView(_ uiView: LineChartView, context: UIViewRepresentableContext<LineChartSwiftUI>) {
        
    }
    
    struct LineChartSwiftUI_Previews: PreviewProvider {
        static var previews: some View {
            LineChartSwiftUI(data: [89, 67, 95])
        }
    }
    
}
