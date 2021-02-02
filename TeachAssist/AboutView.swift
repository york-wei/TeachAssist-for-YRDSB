//
//  AboutView.swift
//  TeachAssist
//
//  Created by York Wei on 2020-04-08.
//  Copyright © 2020 York Wei. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    
    @EnvironmentObject var userDataVM : UserDataViewModel
    
    @Binding var showAbout : Bool
    
    @State var showSheet = false
    
    @State var url = ""
    
    var version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    
    var body: some View {
        ScrollView(showsIndicators: false) {
                
            VStack {
                HStack {
                    
                    Spacer()
                    
                }
                
                ZStack {
                
                    VStack {
                        Image("Logo")
                            .resizable()
                            .frame(width: 250, height: 250)
                        Text("TeachAssist")
                            .font(.system(size: get(type: "title"), weight: .light))
                            .foregroundColor(Color("PrimaryTextColor"))
                            .offset(x: 0, y: -40)
                        Text("Version \(version)")
                            .font(.system(size: get(type: "small"), weight: .regular))
                            .foregroundColor(Color("PrimaryTextColor"))
                            .offset(x: 0, y: -25)
                        
                        VStack {
                            Button(action: {
                                if self.userDataVM.studentID != "demo" {
                                    self.url = "https://www.freeprivacypolicy.com/privacy/view/a2358dd4586ebfe9c5da0acdd49f12a2"
                                    self.showSheet = true
                                }
                                else {
                                    if let url = URL(string: "https://www.freeprivacypolicy.com/privacy/view/a2358dd4586ebfe9c5da0acdd49f12a2") {
                                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                    }
                                }
                            }) {
                                Text("Privacy Policy")
                                    .font(.system(size: get(type: "regular"), weight: .regular))
                                    .padding(5)
                            }
                            
                            Button(action: {
                                if self.userDataVM.studentID != "demo" {
                                    self.url = "https://github.com/york-wei/TeachAssist-iOS"
                                    self.showSheet = true
                                }
                                else {
                                     if let url = URL(string: "https://github.com/york-wei/TeachAssist-iOS") {
                                             UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                     }
                                }
                            }) {
                                Text("Source Code")
                                    .font(.system(size: get(type: "regular"), weight: .regular))
                                    .padding(5)
                            }
                        }
                        .padding(.top, 30)
                        
                        Text("Independently developed and designed by York Wei.")
                            .font(.system(size: get(type: "small"), weight: .regular))
                            .foregroundColor(Color("PrimaryTextColor"))
                            .padding(.top, 50)
                            .padding(.bottom, 10)
                            .multilineTextAlignment(.center)
                        Text("This app is not associated with the TeachAssist Foundation or YRDSB.")
                        .font(.system(size: get(type: "small"), weight: .regular))
                        .foregroundColor(Color("PrimaryTextColor"))
                        .multilineTextAlignment(.center)
                    }
                    
                    HStack {
                        VStack {
                            Button(action: {
                                withAnimation {
                                    self.showAbout.toggle()
                                }
                            }) {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(Color("IconColor"))
                                //.offset(x: 0, y: -1)
                            }
                            .frame(width: 40, height: 40)
                            .background(Color("CellColor"))
                            .clipShape(Circle())
                            .shadow(color: Color("DropShadowColor"), radius: 5, x: 0, y: 3)
                            Spacer()
                        }
                        Spacer()
                    }
                    
                }

            }
            .padding(.top, get(type: "top"))
            .padding(.trailing, get(type: "side"))
            .padding(.leading, get(type: "side"))
        }
        .background(Color("BackgroundColor"))
        .sheet(isPresented: self.$showSheet) {
            WebsiteView(url: self.url, show: self.$showSheet).environmentObject(self.userDataVM)
        }
    }
}

//struct AboutView_Previews: PreviewProvider {
//    static var previews: some View {
//        AboutView()
//    }
//}
