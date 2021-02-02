//
//  BreakdownView.swift
//  TeachAssist
//
//  Created by York Wei on 2020-03-28.
//  Copyright © 2020 York Wei. All rights reserved.
//

import SwiftUI

struct BreakdownView: View {
    
    let k : Double
    let kWeight : Double
    let t : Double
    let tWeight : Double
    let c : Double
    let cWeight : Double
    let a : Double
    let aWeight : Double
    let o : Double
    let oWeight : Double
    let f : Double
    let fWeight : Double
    
    init(course: Course) {
        k = course.knowledge.percent
        kWeight = course.knowledge.weight
        t = course.thinking.percent
        tWeight = course.thinking.weight
        c = course.communication.percent
        cWeight = course.communication.weight
        a = course.application.percent
        aWeight = course.application.weight
        o = course.other.percent
        oWeight = course.other.weight
        f = course.finals.percent
        fWeight = course.finals.weight
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .cornerRadius(20)
                .foregroundColor(Color("CellColor"))
                //.frame(height: 400)
                .shadow(color: Color("DropShadowColor"), radius: 5, x: 0, y: 3)
            VStack (spacing: 25){
                VStack {
                    HStack {
                        Text(String(format: "K/U (Weight: %.1f)", kWeight))
                            .font(.system(size: get(type: "small"), weight: .regular))
                            .foregroundColor(Color("PrimaryTextColor"))
                        Spacer()
                        Text(k >= 0 ? String(format: "%.1f%%", k) : "No Mark")
                            .font(.system(size: get(type: "small"), weight: .regular))
                            .foregroundColor(Color("PrimaryTextColor"))
                    }
                    ProgressBarView(percentage: k)
                        .offset(x: 0, y: 6)
                        .frame(height: 6)
                }
                VStack {
                    HStack {
                        Text(String(format: "T (Weight: %.1f)", tWeight))
                            .font(.system(size: get(type: "small"), weight: .regular))
                            .foregroundColor(Color("PrimaryTextColor"))
                        Spacer()
                        Text(t >= 0 ? String(format: "%.1f%%", t) : "No Mark")
                            .font(.system(size: get(type: "small"), weight: .regular))
                            .foregroundColor(Color("PrimaryTextColor"))
                    }
                    ProgressBarView(percentage: t)
                        .offset(x: 0, y: 6)
                        .frame(height: 6)
                }
                VStack {
                    HStack {
                        Text(String(format: "C (Weight: %.1f)", cWeight))
                            .font(.system(size: get(type: "small"), weight: .regular))
                            .foregroundColor(Color("PrimaryTextColor"))
                        Spacer()
                        Text(c >= 0 ? String(format: "%.1f%%", c) : "No Mark")
                            .font(.system(size: get(type: "small"), weight: .regular))
                            .foregroundColor(Color("PrimaryTextColor"))
                    }
                    ProgressBarView(percentage: c)
                        .offset(x: 0, y: 6)
                        .frame(height: 6)
                }
                VStack {
                    HStack {
                        Text(String(format: "A (Weight: %.1f)", aWeight))
                            .font(.system(size: get(type: "small"), weight: .regular))
                            .foregroundColor(Color("PrimaryTextColor"))
                        Spacer()
                        Text(a >= 0 ? String(format: "%.1f%%", a) : "No Mark")
                            .font(.system(size: get(type: "small"), weight: .regular))
                            .foregroundColor(Color("PrimaryTextColor"))
                    }
                    ProgressBarView(percentage: a)
                        .offset(x: 0, y: 6)
                        .frame(height: 6)
                }
                VStack {
                    HStack {
                        Text(String(format: "O (Weight: %.1f)", oWeight))
                            .font(.system(size: get(type: "small"), weight: .regular))
                            .foregroundColor(Color("PrimaryTextColor"))
                        Spacer()
                        Text(o >= 0 ? String(format: "%.1f%%", o) : "No Mark")
                            .font(.system(size: get(type: "small"), weight: .regular))
                            .foregroundColor(Color("PrimaryTextColor"))
                    }
                    ProgressBarView(percentage: o)
                        .offset(x: 0, y: 6)
                        .frame(height: 6)
                }
                VStack {
                    HStack {
                        Text(String(format: "F (Weight: %.1f)", fWeight))
                            .font(.system(size: get(type: "small"), weight: .regular))
                            .foregroundColor(Color("PrimaryTextColor"))
                        Spacer()
                        Text(f >= 0 ? String(format: "%.1f%%", f) : "No Mark")
                            .font(.system(size: get(type: "small"), weight: .regular))
                            .foregroundColor(Color("PrimaryTextColor"))
                    }
                    ProgressBarView(percentage: f)
                        .offset(x: 0, y: 6)
                        .frame(height: 6)
                }
            }
            .offset(x: 0, y: -4)
            .padding(.leading, 28)
            .padding(.trailing, 28)
            .padding(.top, 38)
            .padding(.bottom, 38)
            //.padding(.leading, 25)
            //.padding(.trailing, 25)
            
        }
    }
}

//struct BreakdownView_Previews: PreviewProvider {
//    static var previews: some View {
//        BreakdownView()
//    }
//}
