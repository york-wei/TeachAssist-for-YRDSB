//
//  LaunchView.swift
//  TeachAssist
//
//  Created by York Wei on 2020-07-02.
//  Copyright © 2020 York Wei. All rights reserved.
//

import SwiftUI
import SSSwiftUIGIFView

struct LaunchView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var hideLogo : Bool
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if !self.hideLogo {
                    if self.colorScheme == .light {
                        SwiftUIGIFPlayerView(gifName: "logolight")
                            .frame(width: 200, height: 200)
                    }
                    else if self.colorScheme == .dark {
                        SwiftUIGIFPlayerView(gifName: "logodark")
                            .frame(width: 200, height: 200)
                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color(UIColor.systemBackground))
        }
    }
}
