//
//  LargeButtonView.swift
//  TeachAssist
//
//  Created by York Wei on 2021-01-30.
//  Copyright © 2021 York Wei. All rights reserved.
//

import SwiftUI

struct LargeButtonView: View {
    
    @State var buttonText : String
    @State var tap = false
    
    var body: some View {
        
        ZStack (alignment: Alignment(horizontal: .center, vertical: .center)) {
            
            Rectangle()
                .foregroundColor(Color(#colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)))
                .frame(height: 60)
                .cornerRadius(15)
                .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)), radius: 20, x: 0, y: 5)
            
            Text(buttonText)
                .foregroundColor(.white)
                .fontWeight(.semibold)
            
        }
        .scaleEffect(tap ? 1.05 : 1)
        .animation(.spring())
        .onTapGesture {
            self.tap = true
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.tap = false
            }
        }
        
    }
}

struct LargeButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LargeButtonView(buttonText: "Sign In")
    }
}
