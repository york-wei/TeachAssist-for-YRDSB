//
//  TeachAssistView.swift
//  TeachAssist
//
//  Created by York Wei on 2021-02-22.
//  Copyright © 2021 York Wei. All rights reserved.
//

import SwiftUI
import StoreKit
import FirebaseAnalytics
import FirebaseRemoteConfig

struct TeachAssistViewNew: View {
    
    @EnvironmentObject var userDataVM: UserDataViewModel
    
    @State private var item: Item?
    
    struct Item: Identifiable {
        let id = UUID()
        var label: String = ""
    }
    
    @State var openedCourse = false
    @State var courseIndex = 0
    
    @State var menu = false
    
    init() {
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().barTintColor = UIColor(named: "BackgroundColor")
        UINavigationBar.appearance().isTranslucent = false
        
    }
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                // Main courses view
                ScrollView(showsIndicators: false) {
                    
                    VStack(alignment: .leading) {
                        
                        VStack {
                            
                            HStack {
                                
                                Spacer()
                                
                            }
                            
                            // Show average ring if marks available
                            if self.userDataVM.overallAverage >= 0 {
                                if self.userDataVM.isLoading {
                                    RingView(percentage: self.userDataVM.overallAverage, redacted: true)
                                        .padding(.top, 20)
                                        .padding(.bottom, 20)
                                    //.redacted(reason: .placeholder)
                                }
                                else {
                                    RingView(percentage: self.userDataVM.overallAverage, redacted: false)
                                        .padding(.top, 20)
                                        .padding(.bottom, 20)
                                }
                                Text("Term Average")
                                    .font(.subheadline)
                                    .fontWeight(.regular)
                                    .foregroundColor(Color("PrimaryTextColor"))
                            }
                            
                        }
                        .padding(.top, 10)
                        .padding(.leading, 30)
                        .padding(.trailing, 30)
                        .padding(.bottom, 30)
                        
                        VStack (spacing: 20) {
                            ForEach(self.userDataVM.courses) { course in
                                if course.parsedAverage != -1.0 {
                                    //NavigationLink(destination: CourseView(opened: self.$openedCourse, courseIndex: self.courseIndex).environmentObject(self.userDataVM), isActive: $openedCourse) {
                                        CourseCellView(opened: self.$openedCourse, index: self.$courseIndex, course: course, redacted: self.userDataVM.isLoading).environmentObject(self.userDataVM)
                                    //}
                                } else {
                                    CourseCellView(opened: self.$openedCourse, index: self.$courseIndex, course: course, redacted: self.userDataVM.isLoading).environmentObject(self.userDataVM)
                                }
                            }
                        }
                        .padding(.bottom, 75)
                        //.redacted(reason: .placeholder)
                        //.disabled(true)
                    }
                    //NavigationLink(destination: CourseView(opened: self.$openedCourse, courseIndex: self.courseIndex).environmentObject(self.userDataVM), isActive: $openedCourse) {
                    //    EmptyView()
                    //}
                }
                .navigationBarTitle("Courses", displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                    self.menu = true
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                }) {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.title)
                        .foregroundColor(Color("PrimaryTextColor"))
                })
                
            }
            
        }
        .accentColor(Color("PrimaryTextColor"))
    }
}
