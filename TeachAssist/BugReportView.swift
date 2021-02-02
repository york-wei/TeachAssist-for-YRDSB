//
//  BugReportView.swift
//  TeachAssist
//
//  Created by York Wei on 2020-06-14.
//  Copyright © 2020 York Wei. All rights reserved.
//

import SwiftUI

struct BugReportView: View {
    
    @EnvironmentObject var userDataVM: UserDataViewModel
    @Binding var showBugReport : Bool
    @State var email : String = ""
    @State var message : String = ""
    @State var showError : Bool = false
    @State var successful : Bool = false
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
                    
                VStack {
                    
                    ZStack {
                        
                        HStack {
                            VStack {
                                Button(action: {
                                    withAnimation {
                                        self.showBugReport = false
                                    }
                                }) {
                                    Image(systemName: "xmark")
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
                        HStack {
                            Spacer()
                            Text("Bug Report")
                                .font(.system(size: get(type: "small"), weight: .regular))
                                .foregroundColor(Color("PrimaryTextColor"))
                            Spacer()
                        }
                        
                    }
                    VStack {
                        ZStack {
                            
                            Rectangle()
                                .cornerRadius(15)
                                .shadow(color: Color("DropShadowColor"), radius: 5, x: 0, y: 3)
                                .foregroundColor(Color("CellColor"))
                                .frame(height: 50)
                                
                                
                                TextField("Your Email", text: $email)
                                    .font(.system(size: get(type: "small"), weight: .regular))
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(Color("PrimaryTextColor"))
                                    .autocapitalization(.none)
                                    .padding()
                                    .disabled(self.successful)
                            
                        }
                        .padding(.bottom, 10)
                        
                        ZStack {
                            
                            Rectangle()
                                .cornerRadius(15)
                                .shadow(color: Color("DropShadowColor"), radius: 5, x: 0, y: 3)
                                .foregroundColor(Color("CellColor"))
                                .frame(height: 50)
                                
                                
                                TextField("Message", text: $message)
                                    .font(.system(size: get(type: "small"), weight: .regular))
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(Color("PrimaryTextColor"))
                                    .padding()
                                    .disabled(self.successful)
                            
                            
                        }
                        .padding(.bottom, 10)
                    }
                    .padding(.top, get(type: "top"))
                    
                    Button(action: {
                        
                        self.showError = false
                        
                        if !self.email.isEmpty && !self.message.isEmpty {
                            self.userDataVM.sendBugReport(email: self.email, message: self.message)
                            self.email = ""
                            self.message = ""
                            self.successful = true
                        }
                        
                        else {
                            self.showError = true
                        }
                        
                    }) {
                        Image(systemName: "paperplane")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color("IconColor"))
                    }
                    .frame(width: 45, height: 45)
                    .background(Color("CellColor"))
                    .clipShape(Circle())
                    .shadow(color: Color("DropShadowColor"), radius: 5, x: 0, y: 3)
                    .padding(.top, get(type: "top"))
                    
                    Text("Please Fill In All Fields")
                        .font(.system(size: get(type: "small"), weight: .regular))
                        .foregroundColor(Color.red)
                        .opacity(showError ? 1 : 0)
                        .offset(x: 0, y: 50)
                    

                }
                .padding(.top, get(type: "top"))
                .padding(.trailing, get(type: "side"))
                .padding(.leading, get(type: "side"))
            
            }
            .background(Color("BackgroundColor"))
            .alert(isPresented: self.$successful) {
                Alert(title: Text("Report Sent"), message: Text("Thank you for reporting this bug. We will fix your issue shortly."), dismissButton: .default(Text("OK")))
            }
        
        
    }
    
} 

//struct BugReportView_Previews: PreviewProvider {
//    static var previews: some View {
//        BugReportView()
//    }
//}
