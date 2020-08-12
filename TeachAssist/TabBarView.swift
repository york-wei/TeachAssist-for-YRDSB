//
//  TabBarView.swift
//  TeachAssist
//
//  Created by York Wei on 2020-03-16.
//  Copyright © 2020 York Wei. All rights reserved.
//

import SwiftUI

struct TabBarView: View {
    
    @Binding var selected : Int
    
    var body: some View {
        
        HStack {
            
            Button(action: {
                self.selected = 0
            }) {
                Image(systemName: "hammer")
                    .foregroundColor(self.selected == 0 ? Color("IconColor").opacity(0.9) : Color("IconColor").opacity(0.4))
                    .font(.system(size: 16, weight: .semibold))
                    .padding(.horizontal)
            }
            
            Spacer(minLength: 15)
            
            Button(action: {
                self.selected = 1
            }) {
                Image(systemName: "percent")
                    .foregroundColor(self.selected == 1 ? Color("IconColor").opacity(0.9) : Color("IconColor").opacity(0.4))
                    .font(.system(size: 16, weight: .semibold))
                .padding(.horizontal)
            }
            
            Spacer(minLength: 15)
            
            Button(action: {
                self.selected = 2
            }) {
                Image(systemName: "gear")
                    .foregroundColor(self.selected == 2 ? Color("IconColor").opacity(0.9) : Color("IconColor").opacity(0.4))
                    .font(.system(size: 16, weight: .semibold))
                .padding(.horizontal)
            }
            
        }
        .frame(height: get(type: "tab"))
        .padding(.horizontal, 35)
        .background(Color("CellColor"))
        .shadow(color: Color("DropShadowColor"), radius: 10, x: 0, y: 0)	

        
    }
}

//struct TabBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabBarView()
//    }
//}
