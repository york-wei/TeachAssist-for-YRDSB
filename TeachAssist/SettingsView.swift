//
//  SettingsView.swift
//  TeachAssist
//
//  Created by York Wei on 2020-04-02.
//  Copyright © 2020 York Wei. All rights reserved.
//

import SwiftUI
import FirebaseAnalytics

struct SettingsView: View {
    
    @EnvironmentObject var userDataVM : UserDataViewModel
    
    @State var openLink = false
    
    @State var showAbout = false
    
    @State var showBugReport = false
    
    var body: some View {
        ZStack {
            
            if showAbout {
                AboutView(showAbout: self.$showAbout).environmentObject(self.userDataVM)
                    .transition(.move(edge: .trailing))
            }
            else if showBugReport {
                BugReportView(showBugReport: self.$showBugReport).environmentObject(self.userDataVM)
                    .transition(.move(edge: .trailing))
            }
            else {
                ScrollView {
                    VStack (spacing: 20) {
                        HStack {
                            Text("Settings")
                                .font(.system(size: get(type: "title"), weight: .light))
                                .foregroundColor(Color("PrimaryTextColor"))
                            Spacer()
                            Button(action: {
                                Analytics.logEvent("logged_out", parameters: ["":""])
                                self.userDataVM.logOut()
                                //withAnimation {
                                    //self.userDataVM.isLoggedIn.toggle()
                                //}
                            }) {
                                Text("Log Out")
                                    .font(.system(size: get(type: "regular")))
                                    .padding()
                            }
                        }
                        ZStack(alignment: .leading) {
                            
                            Rectangle()
                                .cornerRadius(20)
                                .shadow(color: Color("DropShadowColor"), radius: 5, x: 0, y: 3)
                            
                            VStack {
                                HStack {
                                    Text("App Theme")
                                        .font(.system(size: get(type: "regular"), weight: .regular))
                                        .foregroundColor(Color("PrimaryTextColor"))
                                    Spacer()
                                }
                                Picker("Options", selection: self.$userDataVM.theme) {
                                    Text("Light")
                                    .tag("light")
                                    Text("System")
                                    .tag("system")
                                    Text("Dark")
                                    .tag("dark")
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                .animation(.none)
                            }
                            .padding(.trailing, 35)
                            .padding(.leading, 35)
                            
                        }
                        .frame(height: get(type: "cell"))
                        .padding(.top, 20)
                        .foregroundColor(Color("CellColor"))
                        
                        ZStack(alignment: .leading) {
                            
                            Rectangle()
                                .cornerRadius(20)
                                .shadow(color: Color("DropShadowColor"), radius: 5, x: 0, y: 3)
                            
                            HStack {
                                Image("AppStore")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .offset(x: 0, y: 0)
                                Text("Rate This App")
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
                            
                            Analytics.logEvent("clicked_rate", parameters: ["":""])
                            
                            if let url = URL(string: "itms-apps://itunes.apple.com/app/id1479482556") {
                                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            }

                        }
                        ZStack(alignment: .leading) {
                            
                            Rectangle()
                                .cornerRadius(20)
                                .shadow(color: Color("DropShadowColor"), radius: 5, x: 0, y: 3)
                            
                            HStack {
                                Image(systemName: "ant.circle.fill")
                                    .resizable()
                                    .frame(width: 26, height: 26)
                                    .foregroundColor(Color("IconColor"))
                                    .offset(x: -1, y: 0)
                                Text("Report A Bug")
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
                            Analytics.logEvent("clicked_bugreport", parameters: ["":""])
                            withAnimation {
                                self.showBugReport.toggle()
                            }
                        }
                        
                        ZStack(alignment: .leading) {
                            
                            Rectangle()
                                .cornerRadius(20)
                                .shadow(color: Color("DropShadowColor"), radius: 5, x: 0, y: 3)
                            
                            HStack {
                                Image(systemName: "info.circle.fill")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(Color("IconColor"))
                                    .offset(x: -1, y: 0)
                                Text("About")
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
                            Analytics.logEvent("clicked_about", parameters: ["":""])
                            withAnimation {
                                self.showAbout.toggle()
                            }
                        }
                        
                        
                    }
                    .padding(.top, get(type: "top"))
                    .padding(.trailing, get(type: "side"))
                    .padding(.leading, get(type: "side"))
                }
                .background(Color("BackgroundColor"))
            }
        }
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
