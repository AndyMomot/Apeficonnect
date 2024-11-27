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
                return "Aplikacja zapewnia startowy biznesplan, który pomaga użytkownikom zaplanować rozwój w oparciu o bieżące zasoby, potrzeby finansowe, cele i szacunkowe koszty. Oblicza także strategiczne punkty skalowania, aby kierować decyzjami, takimi jak zatrudnienie personelu, wynajem powierzchni lub uruchomienie nowych usług."
            case .second:
                return "Płynnie śledź wszystkie dochody i wydatki, przechodząc od zarobków niezależnych do stabilnych dochodów z działalności gospodarczej. Aplikacja oferuje różne modele skalowania — konserwatywne, zrównoważone i agresywne — umożliwiające użytkownikom ocenę potencjalnego ryzyka i korzyści."
            case .third:
                return "Płynnie śledź wszystkie dochody i wydatki, przechodząc od niezależnych zarobków do stabilnych dochodów z działalności gospodarczej. Aplikacja oferuje różne modele skalowania – konserwatywny, zrównoważony i agresywny – umożliwiając użytkownikom ocenę potencjalnego ryzyka i korzyści."
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
