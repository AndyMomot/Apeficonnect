//
//  TabBarViewModel.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 13.06.2024.
//

import Foundation
import SwiftUI

extension TabBar {
    final class TabBarViewModel: ObservableObject {
        @Published var selection = TabBarSelectionView.start.rawValue
        @Published var isShowTabBar = true
        
        func showTabBar(_ show: Bool) {
            DispatchQueue.main.async { [weak self] in
                self?.isShowTabBar = show
            }
        }
    }
}

extension TabBar {
    enum TabBarSelectionView: Int {
        case start = 0
        case tracker
        case advices
        case goals
    }
    
    struct Item: Identifiable {
        private(set) var id = UUID()
        var imageName: String
        var color: Color
    }
}
