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
        let privacyPolicyURL = URL(string: "https://istnimere.info")
        
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
    
//        var text: String {
//            switch self {
//            case .first:
//                return "Aplikacja zapewnia startowy biznesplan, który pomaga użytkownikom zaplanować rozwój w oparciu o bieżące zasoby, potrzeby finansowe, cele i szacunkowe koszty. Oblicza także strategiczne punkty skalowania, aby kierować decyzjami, takimi jak zatrudnienie personelu, wynajem powierzchni lub uruchomienie nowych usług."
//            case .second:
//                return "Płynnie śledź wszystkie dochody i wydatki, przechodząc od zarobków niezależnych do stabilnych dochodów z działalności gospodarczej. Aplikacja oferuje różne modele skalowania — konserwatywne, zrównoważone i agresywne — umożliwiające użytkownikom ocenę potencjalnego ryzyka i korzyści."
//            case .third:
//                return "Płynnie śledź wszystkie dochody i wydatki, przechodząc od niezależnych zarobków do stabilnych dochodów z działalności gospodarczej. Aplikacja oferuje różne modele skalowania – konserwatywny, zrównoważony i agresywny – umożliwiając użytkownikom ocenę potencjalnego ryzyka i korzyści."
//            }
//        }
        var text: String {
            switch self {
            case .first:
                return "Aplikacja Istnimere to Twój osobisty asystent rozwoju. Pomaga Ci planować cele, organizować zadania oraz śledzić postępy w drodze do sukcesu. Wszystko w jednym miejscu, bez dostępu do internetu."
            case .second:
                return "Zapisuj swoje pomysły i inspiracje w wygodnej sekcji notatek. Dodawaj kategorie i opisy, aby zachować pełną kontrolę nad swoimi planami i nigdy nie zapomnieć najważniejszych szczegółów."
            case .third:
                return "Twórz cele i przypisuj do nich zadania. Oznaczaj wykonanie, monitoruj postępy i wizualizuj swoje osiągnięcia. Dzięki Istnimere z łatwością przejdziesz od planowania do działania."
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
