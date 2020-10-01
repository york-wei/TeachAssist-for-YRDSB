//
//  WebView.swift
//  TeachAssist
//
//  Created by York Wei on 2020-04-04.
//  Copyright © 2020 York Wei. All rights reserved.
//

import SwiftUI
import WebKit

struct WebsiteView: View {
    
    @EnvironmentObject var userDataVM: UserDataViewModel
    var url: String
    @Binding var show: Bool
    
    var body: some View {
        VStack {
            ZStack (alignment: .topLeading) {
                    //Spacer()
//                if self.userDataVM.studentID == "demo" {
//                    VStack {
//                        Spacer()
//                        HStack {
//                            Spacer()
//                            Text("Unavailable for demo")
//                                .foregroundColor(Color("PrimaryTextColor"))
//                                .font(.subheadline)
//                            Spacer()
//                        }
//                        Spacer()
//                    }
//                    .background(Color("BackgroundColor"))
//                }
                //else {
                WebView(url: self.userDataVM.url).environmentObject(self.userDataVM)
                //}
                Button(action: {
                    withAnimation {
                        self.show = false
                    }
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color("IconColor"))
                        .offset(x: 0, y: -1)
                }
                .frame(width: 40, height: 40)
                .background(Color("CellColor"))
                .clipShape(Circle())
                .shadow(color: Color("DropShadowColor"), radius: 5, x: 0, y: 3)
                .padding(.top, 10)
                .padding(.leading, 10)
            }
        }
    }
}

struct WebView: UIViewRepresentable	{
    
    func makeCoordinator() -> WebView.Coordinator {
        Coordinator(self, id: self.userDataVM.studentID, pw: self.userDataVM.studentPW)
    }
    
    @EnvironmentObject var userDataVM: UserDataViewModel
    var url: String
    var web = WKWebView()
    
    func makeUIView(context: UIViewRepresentableContext<WebView>) -> WKWebView {
        guard let url = URL(string: self.url) else {
            return WKWebView()
        }
        
        web.allowsBackForwardNavigationGestures = true
        let request = URLRequest(url: url)
        web.load(request)
        web.navigationDelegate = context.coordinator
        return web
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        
        var webView: WebView
        var studentID: String
        var studentPW: String
        
        //Blueprint
        var selectedLogin = false
        
        init(_ parent: WebView, id: String, pw: String) {
            self.webView = parent
            self.studentID = id
            self.studentPW = pw
        }
                
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            print(webView.url!)
            if webView.url! == URL(string: "https://ta.yrdsb.ca/live/m/index.php?error_message=0") && studentID != "demo" { //If WebView at login page
                self.webView.web.evaluateJavaScript("document.getElementsByName('username')[0].value='\(self.studentID)'", completionHandler: nil) //Enter stored ID
                self.webView.web.evaluateJavaScript("document.getElementsByName('password')[0].value='\(self.studentPW)'", completionHandler: nil) //Enter stored Password
                self.webView.web.evaluateJavaScript("document.getElementsByName('submit')[0].click();", completionHandler: nil) //Click the login button
            }
            else if webView.url! == URL(string: "https://mypathwayplanner.yrdsb.ca/LoginFormIdentityProvider/Login.aspx?ReturnUrl=%2fLoginFormIdentityProvider%2fDefault.aspx") && studentID != "demo" {
                self.webView.web.evaluateJavaScript("document.getElementsByName('UserName')[0].value='\(self.studentID)'", completionHandler: nil)
                self.webView.web.evaluateJavaScript("document.getElementsByName('Password')[0].value='\(self.studentPW)'", completionHandler: nil)
                self.webView.web.evaluateJavaScript("document.getElementsByName('LoginButton')[0].click();", completionHandler: nil) //Click the login button
            }
            else if webView.url! == URL(string: "https://moodle2.yrdsb.ca/login/index.php") && studentID != "demo" {
                self.webView.web.evaluateJavaScript("document.getElementsByName('username')[0].value='\(self.studentID)'", completionHandler: nil)
                self.webView.web.evaluateJavaScript("document.getElementsByName('password')[0].value='\(self.studentPW)'", completionHandler: nil)
                //self.webView.web.evaluateJavaScript("document.getElementsById('loginbtn')[0].click();", completionHandler: nil) //Click the login button
            }
        }
    }
    
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(url: "google.com")
    }
}
