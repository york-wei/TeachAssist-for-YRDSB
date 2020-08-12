//
//  ToolsView.swift
//  TeachAssist
//
//  Created by York Wei on 2020-04-04.
//  Copyright © 2020 York Wei. All rights reserved.
//

import SwiftUI
import FirebaseAnalytics

struct ToolsView: View {
    
    @EnvironmentObject var userDataVM : UserDataViewModel
    @State var url = ""
    @State var showSheet = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                HStack {
                    Text("Student Tools")
                        .font(.system(size: get(type: "title"), weight: .light))
                        .foregroundColor(Color("PrimaryTextColor"))
                    Spacer()
                }
                
                ZStack(alignment: .leading) {
                    
                    Rectangle()
                        .cornerRadius(20)
                        .shadow(color: Color("DropShadowColor"), radius: 5, x: 0, y: 3)
                    
                    HStack {
                        Image(systemName: "cloud.fill")
                            .resizable()
                            .frame(width: 23, height: 17)
                            .foregroundColor(Color("IconColor"))
                        Text("TeachAssist Website")
                            .font(.system(size: get(type: "regular"), weight: .regular))
                            .foregroundColor(Color("PrimaryTextColor"))
                            .padding()
                        Spacer()
                    }
                    .padding(.trailing, 35)
                    .padding(.leading, 35)
                    
                }
                .frame(height: get(type: "cell"))
                .padding(.top, 20)
                .foregroundColor(Color("CellColor"))
                .onTapGesture {
                    Analytics.logEvent("clicked_ta_website", parameters: ["":""])
                    if self.userDataVM.studentID != "demo" {
                        self.url = "https://ta.yrdsb.ca/live/m/index.php?error_message=0"
                        self.showSheet = true
                    }
                    else {
                        if let url = URL(string: "https://ta.yrdsb.ca/live/m/index.php?error_message=0") {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    }
                }
                
                ZStack(alignment: .leading) {
                    
                    Rectangle()
                        .cornerRadius(20)
                        .shadow(color: Color("DropShadowColor"), radius: 5, x: 0, y: 3)
                    
                    HStack {
                        Image("MyBluePrint")
                            .resizable()
                            .frame(width: 25, height: 23)
                            .offset(x: -2, y: 0)
                        Text("My Blueprint")
                            .font(.system(size: get(type: "regular"), weight: .regular))
                            .foregroundColor(Color("PrimaryTextColor"))
                            .padding()
                        Spacer()
                    }
                    .padding(.trailing, 35)
                    .padding(.leading, 35)
                    
                }
                .frame(height: get(type: "cell"))
                .foregroundColor(Color("CellColor"))
                .onTapGesture {
                    Analytics.logEvent("clicked_pathway_planner", parameters: ["":""])
                    
                    if self.userDataVM.studentID != "demo" {
                        self.url = "https://mypathwayplanner.yrdsb.ca/"
                        self.showSheet = true
                    }
                    else {
                        if let url = URL(string: "https://mypathwayplanner.yrdsb.ca/") {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    }
                    
                }
                
                ZStack(alignment: .leading) {
                    
                    Rectangle()
                        .cornerRadius(20)
                        .shadow(color: Color("DropShadowColor"), radius: 5, x: 0, y: 3)
                    
                    HStack {
                        Image(systemName: "book.fill")
                            .resizable()
                            .frame(width: 20, height: 18)
                            .foregroundColor(Color("IconColor"))
                        Text("Moodle")
                            .font(.system(size: get(type: "regular"), weight: .regular))
                            .foregroundColor(Color("PrimaryTextColor"))
                            .padding()
                        Spacer()
                    }
                    .padding(.trailing, 35)
                    .padding(.leading, 35)
                    
                }
                .frame(height: get(type: "cell"))
                .foregroundColor(Color("CellColor"))
                .onTapGesture {
                    Analytics.logEvent("clicked_moodle", parameters: ["":""])
                    if self.userDataVM.studentID != "demo" {
                        self.url = "https://moodle2.yrdsb.ca/login/index.php"
                        self.showSheet = true
                    }
                    else {
                        if let url = URL(string: "https://moodle2.yrdsb.ca/login/index.php") {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    }
                }
                
                ZStack(alignment: .leading) {
                    
                    Rectangle()
                        .cornerRadius(20)
                        .shadow(color: Color("DropShadowColor"), radius: 5, x: 0, y: 3)
                    
                    HStack {
                        Image("Twitter")
                            .resizable()
                            .frame(width: 23, height: 20)
                            .foregroundColor(Color("IconColor"))
                        Text("YRDSB Twitter")
                            .font(.system(size: get(type: "regular"), weight: .regular))
                            .foregroundColor(Color("PrimaryTextColor"))
                            .padding()
                        Spacer()
                    }
                    .padding(.trailing, 35)
                    .padding(.leading, 35)
                    
                }
                .frame(height: get(type: "cell"))
                .foregroundColor(Color("CellColor"))
                .onTapGesture {
                    Analytics.logEvent("clicked_twitter", parameters: ["":""])
                    if self.userDataVM.studentID != "demo" {
                        self.url = "https://twitter.com/yrdsb"
                        self.showSheet = true
                    }
                    else {
                        if let url = URL(string: "https://twitter.com/yrdsb") {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    }
                }
                
                
            }
            .padding(.top, get(type: "top"))
            .padding(.leading, get(type: "side"))
            .padding(.trailing, get(type: "side"))
        }
        .background(Color("BackgroundColor"))
        .sheet(isPresented: $showSheet) {
            WebsiteView(url: self.url, show: self.$showSheet).environmentObject(self.userDataVM)
        }
    }
}

struct ToolsView_Previews: PreviewProvider {
    static var previews: some View {
        ToolsView()
    }
}
