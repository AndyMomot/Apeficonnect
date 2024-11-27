//
//  NextButton.swift
//
//  Created by Andrii Momot on 08.10.2024.
//

import SwiftUI

struct NextButton: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 41)
                    .foregroundStyle(.purpleCustom)
                
                Text(title)
                    .foregroundStyle(.white)
                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 18))
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.8)
                    .padding(.horizontal, 8)
                
            }
            .cornerRadius(8, corners: .allCorners)
        }
    }
}

#Preview {
    ZStack {
        VStack(spacing: 20) {
            NextButton(title: "Komputeryrerererer") {}
                .frame(height: 52)
                .padding(.horizontal)
        }
    }
}
