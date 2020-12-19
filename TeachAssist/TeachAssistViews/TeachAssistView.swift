//
//  TeachAssistView.swift
//  TeachAssist
//
//  Created by York Wei on 2020-02-16.
//  Copyright © 2020 York Wei. All rights reserved.
//

import SwiftUI
import StoreKit
import FirebaseAnalytics

struct TeachAssistView: View {
    
    @State private var item: Item?

        struct Item: Identifiable {
            let id = UUID()
            var label: String = ""
        }
    
    @EnvironmentObject var userDataVM: UserDataViewModel
    
    @State var showAlert = false
    
    @State var opened = false
    @State var index = 0
    
    @State var menu = false
    
    @State var showSheet = false
    
    @State var showWeb = false
    @State var showBug = false
    
    @State var url = ""
    
    @State var type = ""
    
    @State var version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    
    var body: some View {
        
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -100 {
                    withAnimation {
                        self.menu = false
                    }
                }
        }
        
        return ZStack {
            
            if self.opened {
                CourseView(opened: self.$opened, courseIndex: self.index).environmentObject(self.userDataVM)
                    .transition(.move(edge: .trailing))
            }
            else {
                
                ScrollView(showsIndicators: false) {
                    
                    VStack(alignment: .leading) {
                        
                        VStack {
                            
                            HStack {
                                
                                Spacer()
                                
                            }
                            
                            //MENU BUTTON, STUDENT ID, REFRESH BUTTON
                            HStack {
                                
                                Button(action: {
                                    withAnimation() {
                                        self.menu.toggle()
                                    }
                                }) {
                                    Image(systemName: "line.horizontal.3")
                                        .font(.system(size: 15, weight: .semibold))
                                        .foregroundColor(Color("IconColor"))
                                }
                                .frame(width: 44, height: 44)
                                .background(Color("CellColor"))
                                .clipShape(Circle())
                                .shadow(color: Color("DropShadowColor"), radius: 5, x: 0, y: 2)
                                
                                Spacer()
                                
                                Text("ID: " + self.userDataVM.studentID)
                                    .font(.system(size: get(type: "small"), weight: .regular))
                                    .foregroundColor(Color("SecondaryTextColor"))
                                
                                Spacer()
                                Button(action: {
                                    self.userDataVM.isLoading = true
                                    self.userDataVM.load()
                                }) {
                                    if self.userDataVM.isLoading {
                                        ActivityIndicator(isAnimating: .constant(true), style: .medium)
                                    }
                                    else {
                                        Image(systemName: "arrow.clockwise")
                                            .font(.system(size: 15, weight: .semibold))
                                            .foregroundColor(Color("IconColor"))
                                            .offset(x: 0, y: -2)
                                            .rotationEffect(Angle(degrees: 45))
                                    }
                                }
                                .frame(width: 44, height: 44)
                                .background(Color("CellColor"))
                                .clipShape(Circle())
                                .shadow(color: Color("DropShadowColor"), radius: 5, x: 0, y: 2)
                                .disabled(self.userDataVM.isLoading)
                            }
                            
                            //SHOW OVERALL AVERAGE RING THERE ARE MARKS AVAILABLE
                            if self.userDataVM.overallAverage >= 0 {
                                if #available(iOS 14.0, *) {
                                    if self.userDataVM.isLoading {
                                        RingView(percentage: self.userDataVM.overallAverage, redacted: true)
                                            .padding(.top, 20)
                                            .padding(.bottom, 15)
                                            .redacted(reason: .placeholder)
                                    }
                                    else {
                                        RingView(percentage: self.userDataVM.overallAverage, redacted: false)
                                            .padding(.top, 20)
                                            .padding(.bottom, 15)
                                    }
                                } else {
                                    RingView(percentage: self.userDataVM.overallAverage, redacted: false)
                                        .padding(.top, 20)
                                        .padding(.bottom, 15)
                                }
                                Text("Term Average")
                                    .font(.system(size: get(type: "small"), weight: .regular))
                                    .foregroundColor(Color("SecondaryTextColor"))
                            }
                            
                            
                        }
                        .padding(.top, get(type: "top"))
                        .padding(.leading, get(type: "side"))
                        .padding(.trailing, get(type: "side"))
                        .padding(.bottom, 30)
                        

                        if #available(iOS 14.0, *) {
                            if self.userDataVM.isLoading {
                                VStack (spacing: 20) {
                                    ForEach(self.userDataVM.courses) { course in
                                        CourseCellView(opened: self.$opened, index: self.$index, course: course, redacted: self.userDataVM.isLoading).environmentObject(self.userDataVM)
                                    }
                                }
                                .padding(.bottom, 75)
                                .redacted(reason: .placeholder)
                                .disabled(true)
                            }
                            else {
                                VStack (spacing: 20) {
                                    ForEach(self.userDataVM.courses) { course in
                                        CourseCellView(opened: self.$opened, index: self.$index, course: course, redacted: self.userDataVM.isLoading).environmentObject(self.userDataVM)
                                    }
                                }
                                .padding(.bottom, 75)
                            }
                        } else {
                            VStack (spacing: 20) {
                                ForEach(self.userDataVM.courses) { course in
                                    CourseCellView(opened: self.$opened, index: self.$index, course: course, redacted: self.userDataVM.isLoading).environmentObject(self.userDataVM)
                                }
                            }
                            .padding(.bottom, 75)
                        }
                        
                    }
                    
                }
                .background(Color("BackgroundColor"))
            
                if self.userDataVM.courses.count == 0 {
                    VStack {
                        Spacer()
                        if #available(iOS 14.0, *) {
                            if self.userDataVM.isLoading {
                                Text("No Courses Available")
                                    .font(.system(size: get(type: "small"), weight: .semibold))
                                    .foregroundColor(Color("SecondaryTextColor"))
                                    .redacted(reason: .placeholder)
                            }
                            else {
                                Text("No Courses Available")
                                    .font(.system(size: get(type: "small"), weight: .semibold))
                                    .foregroundColor(Color("SecondaryTextColor"))
                            }
                        }
                        else {
                            Text("No Courses Available")
                                .font(.system(size: get(type: "small"), weight: .semibold))
                                .foregroundColor(Color("SecondaryTextColor"))
                        }
                        Spacer()
                    }
                }
                
                //MENU
                ZStack {
                    
                    if self.menu {
                        BlurView(style: .systemUltraThinMaterial)
                            .edgesIgnoringSafeArea(.all)
                            .transition(.opacity)
                            .onTapGesture {
                                withAnimation {
                                    self.menu.toggle()
                                }
                        }
                        //.opacity(0.9)
                    }
                    
                    HStack {
                        VStack(alignment: .leading) {
                            
                            HStack {
                                Spacer()
                            }
                            
                            VStack {
                                
                                VStack (alignment: .leading){//Theme setting
                                    HStack {
                                        Image(systemName: "circle.lefthalf.fill")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .padding(.trailing, 10)
                                            .foregroundColor(Color("IconColor"))
                                        Text("Theme:")
                                            .font(.system(size: get(type: "small"), weight: .regular))
                                            .foregroundColor(Color("SecondaryTextColor"))
                                        //Spacer()
                                        if self.userDataVM.theme == "light" {
                                            Text("Light")
                                                .font(.system(size: get(type: "small"), weight: .semibold))
                                                .foregroundColor(Color("IconColor"))
                                        }
                                        else if self.userDataVM.theme == "dark" {
                                            Text("Dark")
                                                .font(.system(size: get(type: "small"), weight: .semibold))
                                                .foregroundColor(Color("IconColor"))
                                        }
                                        else if self.userDataVM.theme == "system" {
                                            Text("System")
                                                .font(.system(size: get(type: "small"), weight: .semibold))
                                                .foregroundColor(Color("IconColor"))
                                        }
                                    }
                                    .padding(.top, get(type: "menuButton"))
                                    .padding(.bottom, get(type: "menuButton"))
                                    .onTapGesture {
                                        if self.userDataVM.theme == "system" {
                                            self.userDataVM.theme = "dark"
                                        }
                                        else if self.userDataVM.theme == "dark" {
                                            self.userDataVM.theme = "light"
                                        }
                                        else if self.userDataVM.theme == "light" {
                                            self.userDataVM.theme = "system"
                                        }
                                    }
                                    Divider()
                                }
                                
                                VStack (alignment: .leading) {
                                    //Teachassist website
                                    HStack {
                                        Image(systemName: "cloud.fill")
                                            .resizable()
                                            .frame(width: 20, height: 15)
                                            .padding(.trailing, 10)
                                            .foregroundColor(Color("IconColor"))
                                        Text("TeachAssist Website")
                                            .font(.system(size: get(type: "small"), weight: .regular))
                                            .foregroundColor(Color("SecondaryTextColor"))
                                        Spacer()
                                    }
                                    .padding(.top, get(type: "menuButton"))
                                    .padding(.bottom, get(type: "menuButton"))
                                    .onTapGesture {
                                        if self.userDataVM.studentID != "demo" {
                                            self.url = "https://ta.yrdsb.ca/live/m/index.php?error_message=0"
                                            self.userDataVM.url = "https://ta.yrdsb.ca/live/m/index.php?error_message=0"
                                            self.type = "web"
                                            withAnimation {
                                                self.showWeb = true
                                                self.showSheet = true
                                            }
                                        }
                                        else {
                                            if let url = URL(string: "https://ta.yrdsb.ca/live/m/index.php?error_message=0") {
                                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                            }
                                        }
                                    }
                                    Divider()
                                }
                                
                                VStack (alignment: .leading) {
                                    //My blueprint
                                    HStack {
                                        Image(systemName: "m.circle.fill")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(Color("IconColor"))
                                            .padding(.trailing, 10)
                                        Text("My Blueprint")
                                            .font(.system(size: get(type: "small"), weight: .regular))
                                            .foregroundColor(Color("SecondaryTextColor"))
                                        Spacer()
                                    }
                                    .padding(.top, get(type: "menuButton"))
                                    .padding(.bottom, get(type: "menuButton"))
                                    .onTapGesture {
                                        if self.userDataVM.studentID != "demo" {
                                            self.url = "https://mypathwayplanner.yrdsb.ca/"
                                            self.userDataVM.url = "https://mypathwayplanner.yrdsb.ca/"
                                            self.type = "web"
                                            withAnimation {
                                                self.showWeb = true
                                                self.showSheet = true
                                            }
                            
                                        }
                                        else {
                                            if let url = URL(string: "https://mypathwayplanner.yrdsb.ca/") {
                                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                            }
                                        }
                                    }
                                    Divider()
                                }
                                
                                VStack (alignment: .leading) {
                                    //Moodle
                                    HStack {
                                        Image(systemName: "book.fill")
                                            .resizable()
                                            .frame(width: 18, height: 16)
                                            .foregroundColor(Color("IconColor"))
                                            .padding(.trailing, 12)
                                        
                                        Text("Moodle")
                                            .font(.system(size: get(type: "small"), weight: .regular))
                                            .foregroundColor(Color("SecondaryTextColor"))
                                        Spacer()
                                    }
                                    .padding(.top, get(type: "menuButton"))
                                    .padding(.bottom, get(type: "menuButton"))
                                    .onTapGesture {
                                        if self.userDataVM.studentID != "demo" {
                                            self.url = "https://moodle2.yrdsb.ca/login/index.php"
                                            self.userDataVM.url = "https://moodle2.yrdsb.ca/login/index.php"
                                            self.type = "web"
                                            withAnimation {
                                                self.showWeb = true
                                                self.showSheet = true
                                            }
                                        }
                                        else {
                                            if let url = URL(string: "https://moodle2.yrdsb.ca/login/index.php") {
                                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                            }
                                        }
                                    }
                                    Divider()
                                }
                                
                                VStack (alignment: .leading) {
                                    //Twitter
                                    HStack {
                                        Image("Twitter")
                                            .resizable()
                                            .frame(width: 20, height: 17)
                                            .padding(.trailing, 10)
                                        
                                        Text("YRDSB Twitter")
                                            .font(.system(size: get(type: "small"), weight: .regular))
                                            .foregroundColor(Color("SecondaryTextColor"))
                                        Spacer()
                                    }
                                    .padding(.top, get(type: "menuButton"))
                                    .padding(.bottom, get(type: "menuButton"))
                                    .onTapGesture {
                                        if self.userDataVM.studentID != "demo" {
                                            self.url = "https://twitter.com/yrdsb"
                                            self.userDataVM.url = "https://twitter.com/yrdsb"
                                            self.type = "web"
                                            withAnimation {
                                                self.showWeb = true
                                                self.showSheet = true
                                            }
                                        }
                                        else {
                                            if let url = URL(string: "https://twitter.com/yrdsb") {
                                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                            }
                                        }
                                    }
                                    Divider()
                                }
                                
                                VStack (alignment: .leading) {
                                    //rate
                                    HStack {
                                        Image(systemName: "star.fill")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(Color("IconColor"))
                                            .padding(.trailing, 10)
                                        
                                        Text("Rate This App")
                                            .font(.system(size: get(type: "small"), weight: .regular))
                                            .foregroundColor(Color("SecondaryTextColor"))
                                        Spacer()
                                    }
                                    .padding(.top, get(type: "menuButton"))
                                    .padding(.bottom, get(type: "menuButton"))
                                    .onTapGesture {
                                        if let url = URL(string: "itms-apps://itunes.apple.com/app/id1479482556") {
                                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                        }
                                    }
                                    Divider()
                                }
                                
                                VStack (alignment: .leading) {
                                    //rate
                                    HStack {
                                        Image(systemName: "ant.fill")
                                            .frame(width: 20, height: 20)
                                            .padding(.trailing, 10)
                                            .foregroundColor(Color("IconColor"))
                                        
                                        Text("Report A Bug")
                                            .font(.system(size: get(type: "small"), weight: .regular))
                                            .foregroundColor(Color("SecondaryTextColor"))
                                        Spacer()
                                    }
                                    .padding(.top, get(type: "menuButton"))
                                    .padding(.bottom, get(type: "menuButton"))
                                    .onTapGesture {
                                        self.type = "bugreport"
                                        withAnimation {
                                            self.showBug = true
                                            self.showSheet = true
                                        }
                                        
                                    }
                                    Divider()
                                }
                                
                                VStack (alignment: .leading) {
                                    //rate
                                    HStack {
                                        Image(systemName: "escape")
                                            .font(.system(size:  18, weight: .bold))
                                            .padding(.trailing, 12)
                                            .foregroundColor(Color("IconColor"))
                                        
                                        Text("Log Out")
                                            .font(.system(size: get(type: "small"), weight: .regular))
                                            .foregroundColor(Color("SecondaryTextColor"))
                                        Spacer()
                                    }
                                    .padding(.top, get(type: "menuButton"))
                                    .padding(.bottom, get(type: "menuButton"))
                                    .onTapGesture {
                                        withAnimation {
                                            self.userDataVM.logOut()
                                        }
                                    }
                                }
                                
                                if #available(iOS 14.0, *) {
                                    VStack {
                                    }
                                    .fullScreenCover(isPresented: self.$showWeb){
                                        WebsiteView(url: self.url, show: self.$showWeb).environmentObject(self.userDataVM)
                                            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                                    }
                                    VStack {
                                    }
                                    .fullScreenCover(isPresented: self.$showBug){
                                        BugReportView(showBugReport: self.$showBug).environmentObject(self.userDataVM)
                                            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                                    }
                                } else {
                                    VStack {
                                    }
                                    .sheet(isPresented: self.$showSheet) {
                                        if self.type == "web" {
                                            WebsiteView(url: self.url, show: self.$showSheet).environmentObject(self.userDataVM)
                                        }
                                        else if self.type == "bugreport" {
                                            BugReportView(showBugReport: self.$showSheet).environmentObject(self.userDataVM)
                                        }
                                    }
                                }
                            }
                            
                            
                            
                            Spacer()
                            
                            Text("Version " + self.version)
                                .font(.system(size: 9, weight: .regular))
                                .foregroundColor(Color("PrimaryTextColor"))
                            Text("© 2020 York Wei")
                                .font(.system(size: 9, weight: .regular))
                                .foregroundColor(Color("PrimaryTextColor"))
                            
                        }
                        .padding(.leading, 30)
                        .padding(.trailing, 30)
                        .padding(.top, get(type: "menuTopBottom"))
                        .padding(.bottom, get(type: "menuTopBottom"))
                        .frame(width: UIScreen.main.bounds.width / 1.5)
                        .background(Color("CellColor"))
                        .cornerRadius(30, corners: [.topRight, .bottomRight])
                        .shadow(color: Color("DropShadowColor"), radius: 10, x: 0, y: 2)
                        .gesture(drag)
                        Spacer()
                    }
                    
                }
                .offset(x: self.menu ? 0 : -UIScreen.main.bounds.width)
                
            }
        }
        .alert(isPresented: self.$userDataVM.loadFailed) {
            Alert(title: Text("Connection Error"), message: Text("Unable to reach TeachAssist. Your marks could not be updated."), dismissButton: .default(Text("OK")))
        }
//        .sheet(isPresented: $showSheet) {
//            if self.type == "web" {
//                WebsiteView(url: self.url, show: self.$showSheet).environmentObject(self.userDataVM)
//            }
//            else if self.type == "bugreport" {
//                BugReportView(showBugReport: self.$showSheet).environmentObject(self.userDataVM)
//            }
//        }
        
        //}
        .onAppear() {
        
                    if UserDefaults.standard.integer(forKey: "timesOpened") == 10 || UserDefaults.standard.integer(forKey: "timesOpened") == 50 || UserDefaults.standard.integer(forKey: "timesOpened") % 100 == 0 {
                        SKStoreReviewController.requestReview()
                        Analytics.logEvent("requested_review", parameters: ["timesOpened":String(UserDefaults.standard.integer(forKey: "timesOpened"))])
                        UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "timesOpened")+1, forKey: "timesOpened")
                    }
        
                    if UserDefaults.standard.bool(forKey: "notFirstOpen") {
                        if !UserDefaults.standard.bool(forKey: "requestedReview") {
                            SKStoreReviewController.requestReview()
                            Analytics.logEvent("requested_review", parameters: [:])
                            UserDefaults.standard.set(true, forKey: "requestedReview")
                        }
                    }
                    else {
                        UserDefaults.standard.set(true, forKey: "notFirstOpen")
                    }
        
        }
        
    }
    
}

public func get(type: String) -> CGFloat {
    
    var topPadding = 45.0
    var sidePadding = 45.0
    var cellHeight = 115.0
    var titleFont = 35.0
    var regularFont = 15.0
    var smallFont = 13.0
    var tabHeight = 55.0
    var loginTopPadding = 70.0
    var menuTopBottomPadding = 50.0
    var menuButtonPadding = 20.0
    //var scrollPadding = 75.0
    
    switch UIDevice().type {
        
    //    iPhone SE / iPod Touch
    case .iPod5, .iPhoneSE: topPadding = 30.0; sidePadding = 27; cellHeight = 85.0; titleFont = 27.0; regularFont = 12.0; smallFont = 9.5; tabHeight = 40.0; loginTopPadding = 0.0; menuTopBottomPadding = 15.0; menuButtonPadding = 15.0
        
    //    iPhone 6S/7/8
    case .iPhone6S, .iPhone7, .iPhone8, .iPhoneSESecondGen: topPadding = 40.0; sidePadding = 37; cellHeight = 95.0; titleFont = 32.0; regularFont = 14.0; smallFont = 11.5; tabHeight = 55; loginTopPadding = 45.0; menuTopBottomPadding = 50.0; menuButtonPadding = 15.0
    
    //    iPhone 12 Mini
    case .iPhone12Mini: topPadding = 60.0; sidePadding = 37; cellHeight = 95.0; titleFont = 32.0; regularFont = 14.0; smallFont = 11; tabHeight = 55; loginTopPadding = 120.0; menuTopBottomPadding = 120.0; menuButtonPadding = 15.0
        
    //    iPhone 11/XR/iPhone 12
    case .iPhone11, .iPhoneXR, .iPhone12: topPadding = 60.0; cellHeight = 110.0; tabHeight = 80.0; loginTopPadding = 130.0; menuButtonPadding = 25.0; smallFont = 11
        
    //    iPhone X/11 Pro/XS
    case .iPhoneX, .iPhone11Pro, .iPhoneXS, .iPhone12Pro: topPadding = 60.0; sidePadding = 39.0; cellHeight = 105.0; titleFont = 32.0; regularFont = 14.0; smallFont = 11.5; tabHeight = 80.0; loginTopPadding = 130.0
        
    //    iPhone 11ProMax/XSMax
    case .iPhone11ProMax, .iPhoneXSMax, .iPhone12ProMax: topPadding = 70.0; cellHeight = 110.0; tabHeight = 80.0; loginTopPadding = 130.0; menuButtonPadding = 25.0
        
    //    iPhone 6S/7/8 Plus
    default: break
    }
    
    switch type {
    case "top": return CGFloat(topPadding)
    case "side": return CGFloat(sidePadding)
    case "cell": return CGFloat(cellHeight)
    case "title": return CGFloat(titleFont)
    case "regular": return CGFloat(regularFont)
    case "small": return CGFloat(smallFont)
    case "tab": return CGFloat(tabHeight)
    case "loginTop": return CGFloat(loginTopPadding)
    case "menuTopBottom": return CGFloat(menuTopBottomPadding)
    case "menuButton": return CGFloat(menuButtonPadding)
    //case "scroll": return CGFloat(scrollPadding)
    default: return CGFloat(0)
    }
    
}

struct ActivityIndicator: UIViewRepresentable {
    
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
