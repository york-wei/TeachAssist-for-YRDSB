//
//  LoginView.swift
//  TeachAssist
//
//  Created by York Wei on 2021-01-30.
//  Copyright © 2021 York Wei. All rights reserved.
//

import Foundation
import SwiftUI

struct LoginView: View {
    
    // Textfield Input
    @State var studentID = ""
    @State var studentPW = ""
    
    // Animations
    @State var fadeIn = true
    @State var buttonTapped = false
    
    @State var selectedUsername = false
    @State var selectedPassword = false
    
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
                        
                        ZStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(Color("SecondaryTextColor"))
                                .font(.system(.subheadline))
                            Image(systemName: "person.fill")
                                .foregroundColor(Color("IconColor"))
                                .font(.system(.subheadline))
                                .opacity(self.selectedUsername ? 1 : 0)
                        }
                    
                        TextField("Student Number", text: $studentID, onEditingChanged: {_ in
                            withAnimation(.easeInOut(duration: 0.3)) {
                                self.selectedUsername.toggle()
                                self.userDataVM.loadFailed = false
                            }
                        }, onCommit: {})
                            .font(.footnote)
                            .multilineTextAlignment(.leading)
                            .autocapitalization(.none)
                            .keyboardType(.asciiCapable)
                            .disableAutocorrection(true)
                            .foregroundColor(Color("PrimaryTextColor"))
                        
                    }
                    .padding(.bottom, 9)
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color("SecondaryTextColor"))
                            .frame(height: 1)
                        Rectangle()
                            .foregroundColor(Color("IconColor"))
                            .frame(height: 2)
                            .opacity(self.selectedUsername ? 1 : 0)
                    }
                    
                }
                
                VStack {
                
                    HStack {
                        
                        ZStack {
                            Image(systemName: "lock.fill")
                                .foregroundColor(Color("SecondaryTextColor"))
                                .font(.system(.subheadline))
                            Image(systemName: "lock.fill")
                                .foregroundColor(Color("IconColor"))
                                .font(.system(.subheadline))
                                .opacity(self.selectedPassword ? 1 : 0)
                        }
                            
                        SecureTextField(title: "Password", text: $studentPW, onEditingChanged: {_ in
                            withAnimation(.easeInOut(duration: 0.3)) {
                                self.selectedPassword.toggle()
                                self.userDataVM.loadFailed = false
                            }
                        })
                        .frame(height: 20)
                        
                    }
                    .padding(.bottom, 9)
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color("SecondaryTextColor"))
                            .frame(height: 1)
                        Rectangle()
                            .foregroundColor(Color("IconColor"))
                            .frame(height: 2)
                            .opacity(self.selectedPassword ? 1 : 0)
                    }
                    
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
        .opacity(fadeIn ? 0 : 1)
        .offset(x: 0, y: fadeIn ? 50 : 0)
        
    }
    
}

struct SecureTextField: UIViewRepresentable {
    var title: String
    @Binding var text: String
    var onEditingChanged: (Bool) -> Void
    
    func makeUIView(context: Context) -> UITextField {
        let view = UITextField()
        view.placeholder = title
        view.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.footnote)
        view.textColor = UIColor(named: "PrimaryTextColor")
        view.delegate = context.coordinator
        view.isSecureTextEntry = true
        view.endEditing(true)
        view.keyboardType = UIKeyboardType.asciiCapable
        return view
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(p: self)
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        DispatchQueue.main.async {
            uiView.text = text
        }
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        
        var parent: SecureTextField
        
        init(p: SecureTextField) {
            self.parent = p
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            parent.onEditingChanged(true)
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            parent.onEditingChanged(false)
            if let text = textField.text {
                self.parent.text = text
            }
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
        }
    }
    
}
