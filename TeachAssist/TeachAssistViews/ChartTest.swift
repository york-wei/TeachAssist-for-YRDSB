//
//  ChartTest.swift
//  TeachAssist
//
//  Created by York Wei on 2021-02-15.
//  Copyright © 2021 York Wei. All rights reserved.
//

import SwiftUI
//import SwiftUICharts

struct ChartTest: View {
    var body: some View {
        LineView(data: [90, 80, 75, 95, 80, 87.5, 100, 97.3, 89, 94.4, 91.3, 94.4, 89], title: "Line chart", style: ChartStyle(backgroundColor: Color.white, accentColor: Color.purple, gradientColor: GradientColor(start: Color.purple, end: Color.pink), textColor: Color.black, legendTextColor: Color.black, dropShadowColor: Color.gray), valueSpecifier: "%.1f%%")
            .padding(30)
    }
}

struct ChartTest_Previews: PreviewProvider {
    static var previews: some View {
        ChartTest()
            
    }
}
