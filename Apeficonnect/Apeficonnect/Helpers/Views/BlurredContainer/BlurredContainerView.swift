//
//  BlurredContainerView.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 18.11.2024.
//

import SwiftUI

struct BlurredContainerView<C: View>: View {
    var content: C
    var blurOpacity: CGFloat = 0.9
    var colorOpacity: CGFloat = 0.3
    
    init(blurOpacity: CGFloat = 0.9,
         colorOpacity: CGFloat = 0.3,
         @ViewBuilder content: () -> C) {
        self.blurOpacity = blurOpacity
        self.colorOpacity = colorOpacity
        self.content = content()
    }
    
    init(@ViewBuilder content: () -> C) {
        self.content = content()
    }
    
    var body: some View {
        content
            .padding(20)
            .background(
                ZStack {
                    BlurView(style: .light)
                        .opacity(blurOpacity)
                    
                    Color.purpleCustom.opacity(colorOpacity)
                }
                    .cornerRadius(2, corners: .allCorners)
            )
            .overlay {
                RoundedRectangle(cornerRadius: 2)
                    .stroke(Color.purpleCustom, lineWidth: 1)
            }
            .padding(1)
    }
}

#Preview {
    VStack {
        Asset.homeBg.swiftUIImage
            .resizable()
            .scaledToFit()
        
        BlurredContainerView {
            VStack(spacing: 10) {
                HStack {
                    Text("Hello, World!")
                    Spacer()
                }
                Text("Hello, World!")
                Text("Hello, World!")
                Text("Hello, World!")
                
                HStack {
                    Spacer()
                    Text("Hello, World!")
                }
            }
        }
        .padding()
        .offset(y: -100)
        
        Spacer()
    }
}
