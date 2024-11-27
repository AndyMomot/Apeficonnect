//
//  OnboardingViewModel.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 12.06.2024.
//

import Foundation

extension OnboardingView {
    final class OnboardingViewModel: ObservableObject {
        @Published var showPrivacyPolicy = false
        let privacyPolicyURL = URL(string: "https://apeficonnect.info")
        
        @Published var showAuth = false
    }
    
    enum OnboardingItem: Int, CaseIterable {
        case first = 0
        case second
        case third
        
        var image: String {
            switch self {
            case .first:
                return Asset.onboard1.name
            case .second:
                return Asset.onboard2.name
            case .third:
                return Asset.onboard3.name
            }
        }
    
        var text: String {
            switch self {
            case .first:
                return "The app provides a starter business plan, helping users structure their growth based on current resources, funding needs, goals, and estimated costs. It also calculates strategic scaling points to guide decisions, such as hiring staff, renting space, or launching new services."
            case .second:
                return "Track all income and expenses seamlessly as you transition from freelance earnings to stable business revenue. The app offers various scaling models-conservative, balanced, or aggressive-enabling users to evaluate potential risks and rewards."
            case .third:
                return "Analyze which products or services are the most profitable and plan accordingly. Apeficonnect also offers guidance on formalizing a business, covering registration, legal expenses, taxes, and automation tools for smoother operations."
            }
        }
        
        var next: Self {
            switch self {
            case .first:
                return .second
            case .second, .third:
                return .third
            }
        }
    }
}
