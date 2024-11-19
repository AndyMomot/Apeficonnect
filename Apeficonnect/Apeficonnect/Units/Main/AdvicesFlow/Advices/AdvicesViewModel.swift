//
//  AdvicesViewModel.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 19.11.2024.
//

import Foundation

extension AdvicesView {
    final class ViewModel: ObservableObject {
        
        @Published var selectedStrategy: Strategy?
        
        let strategyItems: [Strategy] = [
            .init(
                image: Asset.conservative.name,
                title: "Conservative Strategy",
                header: "Recommendations for the Next Steps for the Conservative Model",
                text: """
                A conservative business development model prioritizes stability, risk mitigation, and sustainable growth. Here are some key recommendations to implement such a strategy:
                1. Thorough Market Research and Risk Assessment:
                In-depth Market Analysis: Conduct a comprehensive analysis of your target market, including customer needs, preferences, and potential competitors.
                Risk Identification and Mitigation: Identify potential risks, such as economic downturns, regulatory changes, or technological disruptions, and develop strategies to mitigate them.
                Financial Forecasting: Create detailed financial projections, including revenue, expenses, and cash flow forecasts, to assess the financial viability of your business.
                """
            ),
            .init(
                image: Asset.balanced.name,
                title: "Balanced Strategy",
                header: "Recommendations for the Next Steps for the Balanced Model",
                text: """
                    A balanced business development model aims to achieve a harmonious blend of growth, stability, and risk management. Here are key recommendations to implement this strategy:
                    1. Strategic Planning and Vision:
                    Clear Vision and Mission: Define a clear vision and mission statement that outlines the long-term goals and values of your business.
                    Strategic Planning: Develop a comprehensive strategic plan that outlines your business objectives, target markets, and competitive advantages.
                    Risk Assessment: Identify potential risks and develop contingency plans to mitigate them.
                    """
            ),
            .init(
                image: Asset.aggressive.name,
                title: "Aggressive Strategy",
                header: "Recommendations for the Next Steps for the Aggressive Model",
                text: """
                An aggressive business development model prioritizes rapid growth and market dominance. Here are key recommendations to implement this strategy:
                1. Bold Vision and Ambitious Goals
                Clear Vision: Develop a clear and inspiring vision for the future of your business.
                Aggressive Goals: Set ambitious, yet achievable, growth targets.
                Risk Tolerance: Be willing to take calculated risks to accelerate growth.
                """
            )
        ]
    }
}

extension AdvicesView {
    struct Strategy: Identifiable {
        private(set) var id = UUID().uuidString
        var image: String
        var title: String
        var header: String
        var text: String
    }
}
