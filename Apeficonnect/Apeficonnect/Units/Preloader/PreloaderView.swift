//
//  PreloaderView.swift
//  Libarorent
//
//  Created by Andrii Momot on 06.10.2024.
//

import SwiftUI

struct PreloaderView: View {
    
    var onDidLoad: () -> Void
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack() {
            LinearGradient(
                colors: [
                    Colors.paleAsh.swiftUIColor,
                    Colors.frostedGray.swiftUIColor],
                startPoint: .leading,
                endPoint: .trailing
            )
            
            VStack {
                VStack(spacing: 20) {
                    Spacer()
                    Asset.logo.swiftUIImage
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 136)
                    
                    Asset.preloaderTitle.swiftUIImage
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 100)
                    Spacer()
                }
                
                Spacer()
                Asset.preloaderBg.swiftUIImage
                    .resizable()
                    .scaledToFit()
                    .overlay {
                        VStack {
                            GradientLoaderView {
                                onDidLoad()
                            }
                            .padding(.horizontal, 16)
                            Spacer()
                        }
                    }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    PreloaderView {}
}
