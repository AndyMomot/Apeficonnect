//
//  BlurredContainerView.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 18.11.2024.
//

import SwiftUI

struct BlurredContainerView<C: View>: View {
    var content: C
    
    init(@ViewBuilder content: () -> C) {
        self.content = content()
    }
    
    let opacity: Double = 0.3
    
    var body: some View {
        content
            .padding(20)
            .background(
                ZStack {
                    BlurView(style: .light)
                        .opacity(0.9)
                    
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.blue.opacity(opacity),
                            Color.purple.opacity(opacity),
                            Color.pink.opacity(opacity),
                            Color.orange.opacity(opacity)
                        ]),
                        startPoint: .leading,
                        endPoint: .trailing)
                }
                    .cornerRadius(30, corners: .allCorners)
            )
            .overlay {
                RoundedRectangle(cornerRadius: 30)
                    .stroke(LinearGradient(
                        gradient: Gradient(colors: [
                            Color.blue,
                            Color.purple,
                            Color.pink,
                            Color.orange]),
                        startPoint: .leading,
                        endPoint: .trailing
                    ), lineWidth: 1)
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
