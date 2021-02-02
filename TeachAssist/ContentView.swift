//
//  ContentView.swift
//  TeachAssist
//
//  Created by York Wei on 2020-02-16.
//  Copyright © 2020 York Wei. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var userDataVM : UserDataViewModel
    @State var launch = true
    @State var hideLogo = false
    
    
    var body: some View {
        
        ZStack {
            
            if self.userDataVM.isLoggedIn {
                
                ZStack(alignment: .bottom) {
                
                    TeachAssistView().environmentObject(self.userDataVM)
                        .transition(.opacity)
                        .zIndex(1)
                                        
                    if self.userDataVM.showMessage {
                        
                        ZStack {
                            
                            BlurView(style: .systemUltraThinMaterial)
                                .edgesIgnoringSafeArea(.vertical)
                                //.opacity(0.9)
                            // This VStack is the popup
                            VStack(spacing: 0) {
                                Text("Developer Message")
                                    .font(.system(size: get(type: "small"), weight: .semibold)).padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color("IconColor"))
                                    .foregroundColor(Color.white)
                                Spacer()
                                Text(self.userDataVM.devMessage)
                                    .font(.system(size: get(type: "small"), weight: .regular))
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(Color("PrimaryTextColor"))
                                    .multilineTextAlignment(.center)
                                    .padding(.trailing)
                                    .padding(.leading)
                                Spacer()
                                Divider()
                                Button(action: {
                                    withAnimation(.easeInOut(duration: 0.8)) {
                                        self.userDataVM.showMessage = false
                                    }
                                }) {
                                    Text("Close")
                                        .font(.system(size: get(type: "small"), weight: .regular))
                                }.padding()
                            }
                            .frame(width: 250, height: 200)
                            .background(Color("CellColor"))
                            .cornerRadius(20)
                            .shadow(color: Color("DropShadowColor"), radius: 10, x: 0, y: 2)
                        }
                        .transition(.opacity)
                        .zIndex(2)
                    }
                    
                }
                .transition(.opacity)
                .zIndex(1)

            }
            
            if !self.userDataVM.isLoggedIn {
                
                LoginView().environmentObject(self.userDataVM)
                    .transition(.opacity)
                    .zIndex(2)
                
            }
            
            if self.launch {
                LaunchView(hideLogo: self.$hideLogo)
                    .transition(.opacity)
                    .zIndex(3)
            }
            
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) {
                self.hideLogo = true
                withAnimation(.easeInOut(duration: 0.8)) {
                    self.launch.toggle()
                }
            }
        }
        
    }
    
}

