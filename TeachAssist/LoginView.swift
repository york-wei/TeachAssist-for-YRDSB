//
//  LoginView.swift
//  TeachAssist
//
//  Created by York Wei on 2021-01-30.
//  Copyright © 2021 York Wei. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    // Textfield Input
    @State var studentID = ""
    @State var studentPW = ""
    
    // Animations
    @State var fadeIn = true
    @State var buttonTapped = false
    
    @EnvironmentObject var userDataVM: UserDataViewModel
    
    var body: some View {
        
        VStack(alignment: .center) {
            
            // Logo
            Image("Logo-1")
                .resizable()
                .frame(width: 115, height: 115)
                .padding(.bottom, 10)
                .shadow(color: Color("RingDropShadowColor"), radius: 3, x: 0, y: 0)
            
            // Texts
            Text("TeachAssist")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color("PrimaryTextColor"))
            
            Text("For YRDSB")
                .font(.subheadline)
                .fontWeight(.regular)
                .foregroundColor(Color("SecondaryTextColor"))
                .padding(3)
            
            // Text Fields
            VStack {
                
                VStack {
                
                    HStack {
                        
                        Image(systemName: "person.fill")
                            .foregroundColor(Color("SecondaryTextColor"))
                            .font(.system(.subheadline))
                    
                        TextField("Student Number", text: $studentID)
                            .font(.footnote)
                            .multilineTextAlignment(.leading)
                            .autocapitalization(.none)
                            .keyboardType(.asciiCapable)
                            .foregroundColor(Color("PrimaryTextColor"))
                        
                    }
                    .padding(.bottom, 9)
                    
                    Rectangle()
                        .foregroundColor(Color("SecondaryTextColor"))
                        .frame(height: 1)
                    
                }
                
                VStack {
                
                    HStack {
                        
                        Image(systemName: "lock.fill")
                            .foregroundColor(Color("SecondaryTextColor"))
                            .font(.system(.subheadline))
                    
                        SecureField("Password", text: $studentPW)
                            .font(.footnote)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(Color("PrimaryTextColor"))
                        
                    }
                    .padding(.bottom, 9)
                    
                    Rectangle()
                        .foregroundColor(Color("SecondaryTextColor"))
                        .frame(height: 1)
                    
                }
                .padding(.top, 50)
                    
            }
            .padding(.top, 60)
            .padding(.trailing, 5)
            .padding(.leading, 5)
                    
            Spacer()
            
            //Login Failed Indicator
            Text("Invalid Login")
                .font(.subheadline)
                .fontWeight(.regular)
                .foregroundColor(Color.red)
                .opacity(self.userDataVM.loadFailed ? 1 : 0)
                .animation(.spring())
            
            Spacer()
            
            // Sign In Button
            ZStack (alignment: Alignment(horizontal: .center, vertical: .center)) {
                
                Rectangle()
                    .foregroundColor(Color(#colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)))
                    .frame(height: 60)
                    .cornerRadius(15)
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)), radius: 20, x: 0, y: 5)
                
                if self.userDataVM.isLoading {
                    ActivityIndicator(isAnimating: true) {
                        $0.color = .white
                    }
                } else {
                    Text("Sign In")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }
                
            }
            .onTapGesture {
                self.buttonTapped = true
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.buttonTapped = false
                }
                self.userDataVM.studentID = self.studentID
                self.userDataVM.studentPW = self.studentPW
                self.userDataVM.loadFailed = false
                self.userDataVM.isLoading = true
                self.userDataVM.load(launch: true)
            }
            .scaleEffect(buttonTapped ? 1.05 : 1)
            .animation(.spring())
            .disabled(self.userDataVM.isLoading)
            
            
        }
        .padding(.top, get(type: "loginTop"))
        .padding(.trailing, 30)
        .padding(.leading, 30)
        .padding(.bottom, 70)
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(Animation.spring()) {
                    fadeIn = false
                }
            }
        }
        .onDisappear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(Animation.spring()) {
                    fadeIn = true
                }
            }
        }
        .opacity(fadeIn ? 0 : 1)
        .offset(x: 0, y: fadeIn ? 50 : 0)
        
    }
    
}
