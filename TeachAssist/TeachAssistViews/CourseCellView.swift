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
                        .foregroundColor(Color("SecondaryTextColor"))
                    
                    if !self.course.period.isEmpty {
                        Text("Period \(self.course.period)")
                            .font(.system(size: get(type: "small"), weight: .regular))
                            .foregroundColor(Color("SecondaryTextColor"))
                    }
                    
                    if !self.course.room.isEmpty {
                        Text("Room \(self.course.room)")
                            .font(.system(size: get(type: "small"), weight: .regular))
                            .foregroundColor(Color("SecondaryTextColor"))
                    }
                    
                    Spacer()
                    
                    if self.course.parsedAverage >= 0 {
                        Text(String(format: "%.1f%%", self.course.parsedAverage))
                            .font(.system(size: get(type: "small"), weight: .medium))
                            .foregroundColor(Color("SecondaryTextColor"))
                            .padding(.top, 2)
                            .padding(.bottom, 2)
                            .padding(.leading, 5)
                            .padding(.trailing, 5)
                            .background(Color("HighlightColor"))
                            .cornerRadius(5)
                    }
                }
                
                if self.course.parsedAverage >= 0 {
                    ProgressBarView(percentage: self.course.parsedAverage)
                        .offset(x: 0, y: 6)
                        .frame(height: 6)
                }
                else {
                    Text("Mark Unavailable")
                        .font(.system(size: get(type: "small"), weight: .regular))
                        .foregroundColor(Color("SecondaryTextColor"))
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
                self.index = self.userDataVM.courses.firstIndex(of: self.course)!
                //print(self.index)
                withAnimation {
                    self.opened.toggle()
                }
            }
        }
        .foregroundColor(Color("CellColor"))
        //.frame(height: get(type: "cell"))
        .padding(.leading, get(type: "side"))
        .padding(.trailing, get(type: "side"))
        
    }
}

//struct CourseCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        CourseCellView(course: Course())
//    }
//}