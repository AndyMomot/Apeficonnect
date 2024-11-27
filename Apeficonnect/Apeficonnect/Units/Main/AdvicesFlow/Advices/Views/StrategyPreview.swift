//
//  StrategyPreview.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 19.11.2024.
//

import SwiftUI

struct StrategyPreview: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            VStack(alignment: .leading, spacing: 15) {
                Text("Wyniki i ryzyka wybranego modelu")
                    .foregroundStyle(Colors.charcoalBlack.swiftUIColor)
                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 20))
                    .baselineOffset(5)
                
                Text("Tutaj zostaną wyświetlone wyniki i ryzyka każdego modelu.")
                    .foregroundStyle(Colors.dimGray.swiftUIColor)
                    .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 14))
                    .baselineOffset(10)
            }
            
            VStack(alignment: .leading, spacing: 15) {
                Text("Zalecenia dotyczące kolejnych kroków dla wybranego modelu")
                    .foregroundStyle(Colors.charcoalBlack.swiftUIColor)
                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 20))
                    .baselineOffset(5)
                
                Text("Tutaj zobaczysz zalecenia dotyczące następnych kroków dla wybranego modelu.")
                    .foregroundStyle(Colors.dimGray.swiftUIColor)
                    .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 14))
                    .baselineOffset(10)
            }
        }
    }
}

#Preview {
    StrategyPreview()
}
