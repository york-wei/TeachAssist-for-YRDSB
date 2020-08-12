//
//  MenuView.swift
//  TeachAssist
//
//  Created by York Wei on 2020-07-17.
//  Copyright © 2020 York Wei. All rights reserved.
//

import SwiftUI
import SwiftUIVisualEffects

struct MenuView: View {
    var body: some View {
        ZStack {
            
            Rectangle()
                .blurEffect()
                .blurEffectStyle(.systemMaterialLight)
                .cornerRadius(40)
            
            VStack(spacing: 30) {
                HStack {
                    Image(systemName: "cloud.fill")
                        .resizable()
                        .frame(width: 23, height: 17)
                        .foregroundColor(Color("IconColor"))
                        .padding(.trailing, 10)
                    Text("TeachAssist Website")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(Color("SecondaryTextColor"))
                    Spacer()
                }
                Spacer()
            }
            .padding(.leading, 30)
            .padding(.top, 70)
        }
        .padding(.top, 10)
        .padding(.bottom, 10)
        .padding(.leading, 40)
        .padding(.trailing, 40)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
