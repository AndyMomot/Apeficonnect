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
                title: "Strategia konserwatywna",
                header: "Zalecenia dotyczące kolejnych kroków dla modelu konserwatywnego",
                text: """
                Konserwatywny model rozwoju biznesu stawia na pierwszym miejscu stabilność, ograniczanie ryzyka i zrównoważony wzrost. Oto kilka kluczowych rekomendacji dotyczących wdrożenia takiej strategii:
                1. Dokładne badanie rynku i ocena ryzyka:
                Głęboka analiza rynku: Przeprowadź kompleksową analizę swojego rynku docelowego, w tym potrzeb klientów, preferencji i potencjalnych konkurentów.
                Identyfikacja i ograniczanie ryzyka: Zidentyfikuj potencjalne ryzyka, takie jak spowolnienia gospodarcze, zmiany regulacyjne lub zakłócenia technologiczne, i opracuj strategie ich ograniczania.
                Prognozowanie finansowe: Twórz szczegółowe prognozy finansowe, w tym prognozy przychodów, wydatków i przepływów pieniężnych, aby ocenić rentowność finansową swojej firmy.
                """
            ),
            .init(
                image: Asset.balanced.name,
                title: "Zrównoważona strategia",
                header: "Zalecenia dotyczące kolejnych kroków dla zrównoważonego modelu",
                text: """
                    Zrównoważony model rozwoju biznesu ma na celu osiągnięcie harmonijnego połączenia wzrostu, stabilności i zarządzania ryzykiem. Oto kluczowe zalecenia dotyczące wdrożenia tej strategii:
                    1. Planowanie strategiczne i wizja:
                    Jasna wizja i misja: Zdefiniuj jasną wizję i oświadczenie misji, które określają długoterminowe cele i wartości Twojej firmy.
                    Planowanie strategiczne: Opracuj kompleksowy plan strategiczny, który określa cele Twojej firmy, rynki docelowe i przewagi konkurencyjne.
                    Ocena ryzyka: Zidentyfikuj potencjalne ryzyka i opracuj plany awaryjne w celu ich złagodzenia.
                    """
            ),
            .init(
                image: Asset.aggressive.name,
                title: "Agresywna strategia",
                header: "Zalecenia dotyczące kolejnych kroków dla modelu agresywnego",
                text: """
                Agresywny model rozwoju biznesu stawia na szybki wzrost i dominację na rynku. Oto kluczowe zalecenia dotyczące wdrożenia tej strategii:
                1. Odważna wizja i ambitne cele
                Jasna wizja: Opracuj jasną i inspirującą wizję przyszłości swojego biznesu.
                Agresywne cele: Ustal ambitne, ale osiągalne cele wzrostu.
                Tolerancja ryzyka: Bądź gotowy na podejmowanie skalkulowanego ryzyka w celu przyspieszenia wzrostu.
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
