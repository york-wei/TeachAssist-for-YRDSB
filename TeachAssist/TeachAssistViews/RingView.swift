//
//  RingView.swift
//  TeachAssist
//
//  Created by York Wei on 2020-07-12.
//  Copyright © 2020 York Wei. All rights reserved.
//

import SwiftUI

struct RingView: View {
    
    let percentage : Double
    @State var redacted : Bool

    var body: some View {
                
        ZStack {
            Circle()
                .stroke(Color("RingBackgroundColor"), style: StrokeStyle(lineWidth: 9))
                .frame(width: 130, height: 130)
            
            if #available(iOS 14.0, *) {
                if redacted {
                    Circle()
                        .trim(from: CGFloat(1), to: 1)
                        .stroke(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3960784314, green: 0.03137254902, blue: 0.862745098, alpha: 1)), Color(#colorLiteral(red: 0.9450980392, green: 0, blue: 0.4823529412, alpha: 1))] ),startPoint: .topLeading, endPoint: .bottomTrailing), style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20, 0], dashPhase: 0))
                        .rotationEffect(Angle(degrees: 90))
                        .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                        .frame(width: 130, height: 130)
                        .shadow(color: Color("RingDropShadowColor"), radius: 3, x: 0, y: 3)
                }
                else {
                    Circle()
                        .trim(from: CGFloat(1 - self.percentage / 100), to: 1)
                        .stroke(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3960784314, green: 0.03137254902, blue: 0.862745098, alpha: 1)), Color(#colorLiteral(red: 0.9450980392, green: 0, blue: 0.4823529412, alpha: 1))] ),startPoint: .topLeading, endPoint: .bottomTrailing), style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20, 0], dashPhase: 0))
                        .rotationEffect(Angle(degrees: 90))
                        .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                        .frame(width: 130, height: 130)
                        .shadow(color: Color("RingDropShadowColor"), radius: 3, x: 0, y: 3)
                }
            }
            else {
                Circle()
                    .trim(from: CGFloat(1 - self.percentage / 100), to: 1)
                    .stroke(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3960784314, green: 0.03137254902, blue: 0.862745098, alpha: 1)), Color(#colorLiteral(red: 0.9450980392, green: 0, blue: 0.4823529412, alpha: 1))] ),startPoint: .topLeading, endPoint: .bottomTrailing), style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20, 0], dashPhase: 0))
                    .rotationEffect(Angle(degrees: 90))
                    .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                    .frame(width: 130, height: 130)
                    .shadow(color: Color("RingDropShadowColor"), radius: 3, x: 0, y: 3)
            }
            
             Text(String(format: "%.1f%%", self.percentage))
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color("PrimaryTextColor"))
        }
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView(percentage: 80, redacted: false)
    }
}
