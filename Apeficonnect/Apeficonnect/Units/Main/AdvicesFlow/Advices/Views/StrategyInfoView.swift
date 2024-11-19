//
//  StrategyInfoView.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 19.11.2024.
//

import SwiftUI

struct StrategyInfoView: View {
    var header: String
    var text: String
    
    var body: some View {
        BlurredContainerView {
            VStack(alignment: .leading, spacing: 20) {
                Text(header)
                    .foregroundStyle(Colors.charcoalBlack.swiftUIColor)
                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 20))
                    .baselineOffset(5)
                
                Text(text)
                    .foregroundStyle(Colors.dimGray.swiftUIColor)
                    .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 14))
                    .baselineOffset(10)
            }
        }
    }
}

#Preview {
    StrategyInfoView(
        header: "Recommendations for the Next Steps for the Conservative Model",
        text: """
        A conservative business development model prioritizes stability, risk mitigation, and sustainable growth. Here are some key recommendations to implement such a strategy:
        1. Thorough Market Research and Risk Assessment:
        In-depth Market Analysis: Conduct a comprehensive analysis of your target market, including customer needs, preferences, and potential competitors.
        Risk Identification and Mitigation: Identify potential risks, such as economic downturns, regulatory changes, or technological disruptions, and develop strategies to mitigate them.
        Financial Forecasting: Create detailed financial projections, including revenue, expenses, and cash flow forecasts, to assess the financial viability of your business.
        """
    )
    .padding()
}
