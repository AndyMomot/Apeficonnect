//
//  NextButton.swift
//  Libarorent
//
//  Created by Andrii Momot on 08.10.2024.
//

import SwiftUI

struct NextButton: View {
    var title: String
    var style: Style = .primary
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                style.bgColor
                
                Text(title)
                    .foregroundStyle(style.textColor)
                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 18))
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.8)
                    .padding(.horizontal, 8)
                
            }
            .cornerRadius(8, corners: .allCorners)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.blue, lineWidth: 1)
            }
            .padding(1)
            .shadow(color: .blue.opacity(0.1), radius: 8)
        }
    }
}

extension NextButton {
    enum Style {
        case primary
        case secondary(color: Color)
        
        var bgColor: Color {
            switch self {
            case .primary:
                return .blue
            case .secondary(let color):
                return color
            }
        }
        
        var textColor: Color {
            switch self {
            case .primary:
                return .white
            case .secondary:
                return .blue
            }
        }
    }
}

#Preview {
    ZStack {
        VStack(spacing: 20) {
            NextButton(title: "Komputeryrerererer") {}
                .frame(width: 200, height: 44)
            
            NextButton(title: "Komputeryrerererer", style: .secondary(color: .white)) {}
                .frame(width: 200, height: 44)
        }
    }
}
