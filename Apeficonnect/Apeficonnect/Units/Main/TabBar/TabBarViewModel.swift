//
//  TabBarViewModel.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 13.06.2024.
//

import Foundation

extension TabBar {
    final class TabBarViewModel: ObservableObject {
        @Published var selection = TabBarSelectionView.start.rawValue
        @Published var showTabBar = true
    }
}

extension TabBar {
    enum TabBarSelectionView: Int {
        case start = 0
        case plans
        case tracker
        case advices
        case goals
    }
    
    struct Item: Identifiable {
        private(set) var id = UUID()
        var imageName: String
    }
}
