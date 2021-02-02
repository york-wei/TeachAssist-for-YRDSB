//
//  LoginView.swift
//  TeachAssist
//
//  Created by York Wei on 2020-02-21.
//  Copyright © 2020 York Wei. All rights reserved.
//

import SwiftUI

struct OldLoginView: View {
    
    @State var studentID = ""
    @State var studentPW = ""
    @State var loggingIn = false
    @State var loginSuccessful = false
    @EnvironmentObject var userDataVM: UserDataViewModel
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            VStack {
                
                if loginSuccessful {
                    Rectangle()
                        .foregroundColor(Color("BackgroundColor"))
                        .onAppear {
                            withAnimation (Animation.default.delay(0.2)){
                                self.userDataVM.isLoggedIn.toggle()
                            }
                        }
                }
                else {
                    
                    VStack {
                        Image("Logo")
                            .resizable()
                            .frame(width: 250, height: 250)
                        Text("TeachAssist")
                            .font(.system(size: get(type: "title"), weight: .light))
                            .foregroundColor(Color("SecondaryTextColor"))
                            .offset(x: 0, y: -40)
                        
                        VStack {
                            
                            VStack {
                                ZStack {
                                    
                                    Rectangle()
                                        .cornerRadius(15)
                                        .shadow(color: Color("DropShadowColor"), radius: 5, x: 0, y: 3)
                                        .foregroundColor(Color("CellColor"))
                                        .frame(height: 50)
                                    
                                    ZStack {
                                        
                                        HStack {
                                            Image(systemName: "person.fill")
                                                .foregroundColor(Color("IconColor"))
                                            Spacer()
                                        }
                                        .offset(x: 20, y: 0)
                                        
                                        
                                        TextField("Student ID", text: $studentID)
                                            .font(.system(size: get(type: "small"), weight: .regular))
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(Color("SecondaryTextColor"))
                                            .autocapitalization(.none)
                                            .keyboardType(.asciiCapable)
                                        
                                    }
                                    
                                }
                                .padding(.bottom, 10)
                                
                                ZStack {
                                    
                                    Rectangle()
                                        .cornerRadius(15)
                                        .shadow(color: Color("DropShadowColor"), radius: 5, x: 0, y: 3)
                                        .foregroundColor(Color("CellColor"))
                                        .frame(height: 50)
                                    
                                    ZStack {
                                        
                                        HStack {
                                            Image(systemName: "lock.fill")
                                                .foregroundColor(Color("IconColor"))
                                            Spacer()
                                        }
                                        .offset(x: 20, y: 0)
                                        
                                        
                                        SecureField("Password", text: $studentPW)
                                            .font(.system(size: get(type: "small"), weight: .regular))
                                            .foregroundColor(Color("SecondaryTextColor"))
                                            .multilineTextAlignment(.center)
                                        
                                    }
                                    
                                }
                            }
                            .offset(x: 0, y: -20)
                        }
                            
                            Spacer()
                            
                            //LargeButtonView(buttonText: "Sign In")
                            
//                            Button(action: {
//                                self.userDataVM.studentID = self.studentID
//                                self.userDataVM.studentPW = self.studentPW
//                                self.userDataVM.loadFailed = false
//                                self.userDataVM.isLoading = true
//                                self.userDataVM.load(launch: true)
//                            }) {
//                                if self.userDataVM.isLoading {
//                                    ActivityIndicator(isAnimating: .constant(true), style: .medium)
//                                }
//                                else {
//                                    Image(systemName: "arrow.uturn.right")
//                                    .font(.system(size: 16, weight: .medium))
//                                    .foregroundColor(Color("IconColor"))
//                                }
//                            }
//                            .frame(width: 50, height: 50)
//                            .background(Color("CellColor"))
//                            .clipShape(Circle())
//                            .shadow(color: Color("DropShadowColor"), radius: 5, x: 0, y: 3)
//                            .offset(x: 0, y: 30)
//                            .disabled(self.userDataVM.isLoading)
                            
                            Text("Invalid Login")
                                .font(.system(size: get(type: "small"), weight: .regular))
                                .foregroundColor(Color.red)
                                .opacity(self.userDataVM.loadFailed ? 1 : 0)
                                .offset(x: 0, y: 50)
                    }
                    //.padding(.trailing, 50)
                    //.padding(.leading, 50)
                    //.padding(.top, get(type: "loginTop"))
                }
                
            }
        }
        .background(Color("BackgroundColor"))
    }
}
