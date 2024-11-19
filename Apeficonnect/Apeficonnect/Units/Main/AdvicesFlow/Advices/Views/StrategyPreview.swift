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
                Text("Results and Risks of the Selected Model")
                    .foregroundStyle(Colors.charcoalBlack.swiftUIColor)
                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 20))
                    .baselineOffset(5)
                
                Text("The results and risks of each model will be displayed here.")
                    .foregroundStyle(Colors.dimGray.swiftUIColor)
                    .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 14))
                    .baselineOffset(10)
            }
            
            VStack(alignment: .leading, spacing: 15) {
                Text("Recommendations for the Next Steps for the Selected Model")
                    .foregroundStyle(Colors.charcoalBlack.swiftUIColor)
                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 20))
                    .baselineOffset(5)
                
                Text("Here you will see recommendations for next steps for the selected model.")
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
