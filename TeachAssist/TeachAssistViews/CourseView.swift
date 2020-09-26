//
//  CourseView.swift
//  TeachAssist
//
//  Created by York Wei on 2020-03-22.
//  Copyright © 2020 York Wei. All rights reserved.
//

import SwiftUI
import FirebaseAnalytics

struct CourseView: View {
    
    @EnvironmentObject var userDataVM : UserDataViewModel
    
    @Binding var opened : Bool
    @State var courseIndex : Int
        
    @State var choice = 0
    @State var editing = false
    
    @State var add = false
    
    var body: some View {
        
        ZStack {
            
            if self.add {
                AddEvaluationView(add: self.$add).environmentObject(self.userDataVM)
            }
            else {
                    ScrollView (showsIndicators: false) {
                    
                    VStack (alignment: .leading) {
                            
                            HStack {
                                
                                Spacer()
                                
                            }
                            
                            HStack {
                                Button(action: {
                                    withAnimation {
                                        self.opened.toggle()
                                    }
                                }) {
                                    Image(systemName: "chevron.left")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(Color("IconColor"))
                                        .offset(x: -1, y: 0)
                                }
                                .frame(width: 40, height: 40)
                                .background(Color("CellColor"))
                                .clipShape(Circle())
                                .shadow(color: Color("DropShadowColor"), radius: 5, x: 0, y: 3)
                                
                                Spacer()
                                
                                Text(self.userDataVM.courses[courseIndex].code)
                                    .font(.system(size: get(type: "small"), weight: .regular))
                                    .foregroundColor(Color("SecondaryTextColor"))
                                
                                Spacer()
                                
                                Button(action: {
                                    if self.editing {
                                        self.userDataVM.editCourse = Course(course: self.userDataVM.courses[self.courseIndex])
                                    }
                                    else {
                                        Analytics.logEvent("clicked_edit_eval", parameters: ["":""])
                                        self.userDataVM.editCourse = Course(course: self.userDataVM.courses[self.courseIndex])
                                    }
                                    withAnimation {
                                        self.editing.toggle()
                                        self.choice = 0
                                    }
                                }) {
                                    Image(systemName: !editing ? "pencil" : "pencil.slash")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(Color("IconColor"))
                                }
                                .frame(width: 40, height: 40)
                                .background(Color("CellColor"))
                                .clipShape(Circle())
                                .shadow(color: Color("DropShadowColor"), radius: 5, x: 0, y: 3)
                                
                            }
                            
                        VStack {
                            HStack {
                                Spacer()
                            }
                            RingView(percentage: !editing ? self.userDataVM.courses[courseIndex].parsedAverage : self.userDataVM.editCourse.parsedAverage, redacted: false)
                            .padding(.top, 20)
                            .padding(.bottom, 15)
                            Text(!editing ? "Course Average" : "Predicted Course Average")
                            .font(.system(size: get(type: "small"), weight: .regular))
                            .foregroundColor(Color("SecondaryTextColor"))
                        }.padding(.bottom, 30)
                        
                        Picker("Options", selection: $choice) {
                            Text("Assignments")
                            .tag(0)
                            Text("Trends")
                            .tag(1)
                            Text("Breakdown")
                            .tag(2)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .animation(.none)
                        
                        if choice == 0 {
                            
                            VStack (spacing: 20) {
                                
                                if editing {
                                    ZStack {
                                        Rectangle()
                                            .foregroundColor(Color("CellColor"))
                                            .frame(height: 100)
                                            .cornerRadius(20)
                                            .shadow(color: Color("DropShadowColor"), radius: 5, x: 0, y: 3)
                                        VStack {
                                            Image(systemName: "plus")
                                                .font(.system(size: 16, weight: .semibold))
                                                .foregroundColor(Color("IconColor"))
                                                .padding(5)
                                            Text("Add New Evaluation")
                                                .font(.system(size: get(type: "small"), weight: .semibold))
                                                .foregroundColor(Color("SecondaryTextColor"))
                                        }
//                                        .sheet(isPresented: self.$add) {
//                                            AddEvaluationView(add: self.$add).environmentObject(self.userDataVM)
//                                        }
                                    }
                                    .onTapGesture {
                                        Analytics.logEvent("clicked_add_eval", parameters: ["":""])
                                        withAnimation {
                                            self.add.toggle()
                                        }
                                    }
                                    //.animation(.none)
                                }
                                
                                if(!editing) {
                                    ForEach(self.userDataVM.courses[courseIndex].evaluations.reversed()) { evaluation in
                                        EvaluationView(editing: self.editing, evaluation: evaluation)
                                    }
                                    .environmentObject(self.userDataVM)
                                }
                                else {
                                    
                                    ForEach(self.userDataVM.editCourse.evaluations.reversed()) { evaluation in
                                        EvaluationView(editing: self.editing, evaluation: evaluation)
                                    }
                                    .environmentObject(self.userDataVM)
                                }
                                
                            }
                            .padding(.top, 40)
                            .padding(.bottom, 75)
                            .animation(.none)
                        }
                        else if choice == 1 {
                            
                            VStack (spacing: 20) {
                                TrendView(course: !self.editing ? self.userDataVM.courses[courseIndex] : self.userDataVM.editCourse)
                            }
                            .padding(.top, 40)
                            .padding(.bottom, 75)
                            
                        }
                        else if choice == 2 {
                            BreakdownView(course: !self.editing ? self.userDataVM.courses[courseIndex] : self.userDataVM.editCourse)
                            .padding(.top, 40)
                            .padding(.bottom, 75)
                        }
                        
                    }
                    .padding(.leading, get(type: "side"))
                    .padding(.trailing, get(type: "side"))
                    .padding(.top, get(type: "top"))
                    .animation(.none)

                }
                .background(Color("BackgroundColor"))
            }
        }
    }

}
//
//struct CourseView_Previews: PreviewProvider {
//    static var previews: some View {
//        CourseView(course: Course())
//    }
//}
