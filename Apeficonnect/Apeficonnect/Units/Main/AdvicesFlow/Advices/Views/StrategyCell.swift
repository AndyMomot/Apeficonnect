//
//  StrategyCell.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 19.11.2024.
//

import SwiftUI

struct StrategyCell: View {
    var image: String
    var title: String
    var isSelected: Bool
    
    var body: some View {
        ZStack {
            BlurredContainerView {
                HStack {
                    Spacer()
                    VStack(spacing: 14) {
                        Image(image)
                            .resizable()
                            .scaledToFit()
                        
                        Text(title)
                            .foregroundStyle(Colors.charcoalBlack.swiftUIColor)
                            .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 12))
                            .lineLimit(2)
                            .minimumScaleFactor(0.8)
                            .multilineTextAlignment(.center)
                    }
                    Spacer()
                }
            }
            .overlay {
                if isSelected {
                    BlurredContainerView(blurOpacity: 0.6) {
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Image(systemName: "checkmark")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(.white)
                                Spacer()
                            }
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    HStack(spacing: 14) {
        StrategyCell(
            image: Asset.conservative.name,
            title: "Conservative Strategy",
            isSelected: false
        )
        
        StrategyCell(
            image: Asset.balanced.name,
            title: "Balanced Strategy",
            isSelected: true
        )
        
        StrategyCell(
            image: Asset.aggressive.name,
            title: "Aggressive Strategy",
            isSelected: false
        )
    }
    .frame(height: 140)
    .padding(.horizontal, 16)
}
