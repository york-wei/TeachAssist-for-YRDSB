//
//  LoginView.swift
//  TeachAssist
//
//  Created by York Wei on 2021-01-30.
//  Copyright © 2021 York Wei. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    @State var studentID = ""
    @State var studentPW = ""
    @EnvironmentObject var userDataVM: UserDataViewModel
    
    var body: some View {
        
        VStack(alignment: .center) {
            
            // Logo
            Image("Logo-1")
                .resizable()
                .frame(width: 115, height: 115)
                .padding(.bottom, 10)
            
            // Texts
            Text("TeachAssist")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color(#colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)))
            
            Text("For YRDSB")
                .font(.subheadline)
                .fontWeight(.regular)
                .foregroundColor(Color(#colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 0.3)))
                .padding(3)
            
            // Text Fields
            VStack {
                
                VStack {
                
                    HStack {
                        
                        Image(systemName: "person.fill")
                            .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)))
                            .font(.system(.subheadline))
                    
                        TextField("Student Number", text: $studentID)
                            .font(.footnote)
                            .multilineTextAlignment(.leading)
                            .autocapitalization(.none)
                            .keyboardType(.asciiCapable)
                            .onTapGesture {
                                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                            }
                        
                    }
                    .padding(.bottom, 9)
                    
                    Rectangle()
                        .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)))
                        .frame(height: 1)
                    
                }
                
                VStack {
                
                    HStack {
                        
                        Image(systemName: "lock.fill")
                            .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)))
                            .font(.system(.subheadline))
                    
                        SecureField("Password", text: $studentPW)
                            .font(.footnote)
                            .multilineTextAlignment(.leading)
                            .onTapGesture {
                                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                            }
                        
                    }
                    .padding(.bottom, 9)
                    
                    Rectangle()
                        .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)))
                        .frame(height: 1)
                    
                }
                .padding(.top, 50)
                    
            }
            .padding(.top, 60)
            .padding(.trailing, 5)
            .padding(.leading, 5)
                    
            Spacer()
            
            // Sign In Button
            LargeButtonView(buttonText: "Sign In")
            
        }
        .padding(.top, get(type: "loginTop"))
        .padding(.trailing, 30)
        .padding(.leading, 30)
        .padding(.bottom, 70)
        
    }
    
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
