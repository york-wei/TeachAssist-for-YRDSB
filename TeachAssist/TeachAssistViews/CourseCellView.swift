//
//  CourseView.swift
//  TeachAssist
//
//  Created by York Wei on 2020-02-17.
//  Copyright © 2020 York Wei. All rights reserved.
//

import SwiftUI

struct CourseCellView: View {
    
    @Binding var opened : Bool
    @Binding var index: Int
    @State var course : Course
    @State var redacted : Bool
    @EnvironmentObject var userDataVM: UserDataViewModel
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            
            Rectangle()
                .cornerRadius(20)
                .shadow(color: Color("DropShadowColor"), radius: 5, x: 0, y: 2)
                
            VStack (alignment: .leading){
                
                HStack {
                    
                    Text(self.course.code)
                        .font(.system(size: get(type: "small"), weight: .semibold))
                        .foregroundColor(Color("PrimaryTextColor"))
                    
                    if !self.course.period.isEmpty {
                        Text("Period \(self.course.period)")
                            .font(.system(size: get(type: "small"), weight: .regular))
                            .foregroundColor(Color("PrimaryTextColor"))
                    }
                    
                    if !self.course.room.isEmpty {
                        Text("Room \(self.course.room)")
                            .font(.system(size: get(type: "small"), weight: .regular))
                            .foregroundColor(Color("PrimaryTextColor"))
                    }
                    
                    Spacer()
                    
                    if self.course.parsedAverage >= 0 {
                        Text(String(format: "%.1f%%", self.course.parsedAverage))
                            .font(.system(size: get(type: "small"), weight: .medium))
                            .foregroundColor(Color("PrimaryTextColor"))
                            .padding(.top, 2)
                            .padding(.bottom, 2)
                            .padding(.leading, 5)
                            .padding(.trailing, 5)
                            .background(Color("HighlightColor"))
                            .cornerRadius(5)
                    }
                }
                
                if self.course.parsedAverage >= 0 {
                    if #available(iOS 14.0, *) {
                        if self.redacted {
                            ProgressBarView(percentage: 0)
                                .offset(x: 0, y: 6)
                                .frame(height: 6)
                        }
                        else {
                            ProgressBarView(percentage: self.course.parsedAverage)
                                .offset(x: 0, y: 6)
                                .frame(height: 6)
                        }
                    }
                    else {
                        ProgressBarView(percentage: self.course.parsedAverage)
                            .offset(x: 0, y: 6)
                            .frame(height: 6)
                    }
                }
                else {
                    Text("Mark Unavailable")
                        .font(.system(size: get(type: "small"), weight: .regular))
                        .foregroundColor(Color("PrimaryTextColor"))
                        .offset(x: 0, y: 6)
                }
                
            }
            .offset(x: 0, y: -4)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.leading, 28)
            .padding(.trailing, 28)
            .padding(.top, 38)
            .padding(.bottom, 38)
            
        }
        .onTapGesture {
            if self.course.parsedAverage != -1 {
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                self.index = self.userDataVM.courses.firstIndex(of: self.course)!
                //print(self.index)
                withAnimation {
                    self.opened.toggle()
                }
            }
        }
        .foregroundColor(Color("CellColor"))
        //.frame(height: get(type: "cell"))
        .padding(.leading, 30)
        .padding(.trailing, 30)
        
    }
}

//struct CourseCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        CourseCellView(course: Course())
//    }
//}
