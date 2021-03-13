//
//  ProgressBarView.swift
//  TeachAssist
//
//  Created by York Wei on 2020-02-16.
//  Copyright © 2020 York Wei. All rights reserved.
//

import SwiftUI

struct ProgressBarView: View {
    
    private let percentage : Double
    private let startColor : Color
    private let endColor : Color
    
    @State var animate = false
    @State var animation = true
    
    init(percentage: Double) {
        
        if percentage <= 100 {
            self.percentage = percentage / 100
        }
        else {
            self.percentage = 1
        }
        
        
//        if percentage < 70 {
//            self.startColor = Color("ProgressBarRedStartColor")
//            self.endColor = Color("ProgressBarRedEndColor")
//        }
//        else if percentage < 85 {
//            self.startColor = Color("ProgressBarYellowStartColor")
//            self.endColor = Color("ProgressBarYellowEndColor")
//        }
//        else {
//            self.startColor = Color("ProgressBarGreenStartColor")
//            self.endColor = Color("ProgressBarGreenEndColor")
//        }
        self.startColor = Color(#colorLiteral(red: 0.9441892505, green: 0, blue: 0.4814293981, alpha: 1))//Color(#colorLiteral(red: 0.3960784314, green: 0.03137254902, blue: 0.862745098, alpha: 1))//Color("ButtonColor")
        self.endColor = Color(#colorLiteral(red: 0.3960784314, green: 0.03137254902, blue: 0.862745098, alpha: 1))//Color(#colorLiteral(red: 0.9441892505, green: 0, blue: 0.4814293981, alpha: 1))//Color("ButtonColor")
        
    }
    
    var body: some View {
        
        ZStack {
            
            GeometryReader { geometryReader in
                
                //Background
                Capsule()
                    .foregroundColor(Color("ProgressBarBackgroundColor"))
                    .frame(height: 5)
                
                //Progress
                Capsule()
                    .fill(LinearGradient(gradient: Gradient(colors: [self.startColor, self.endColor]), startPoint: .leading, endPoint: .trailing))
                    .frame(width: (self.animate && self.percentage >= 0) ? CGFloat(geometryReader.size.width)*CGFloat(self.percentage) : 0, height: 3)
                    .hueRotation(.degrees(animate ? 0 : -45))
                    .animation(self.animation ? Animation.easeInOut(duration: 0.6).delay(0.3) : .none)
                    .offset(x: 1, y: 1)
                
            }
            .onAppear {
                self.animate = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.animation = false
                }
            }
            
            
        }
        
    }
    
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView(percentage: 90)
    }
}
