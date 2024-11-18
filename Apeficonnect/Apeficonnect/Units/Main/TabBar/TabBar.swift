//
//  TabBar.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 13.06.2024.
//

import SwiftUI

struct TabBar: View {
    @StateObject private var viewModel = TabBarViewModel()
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        TabView(selection: $viewModel.selection) {
            HomeView()
                .tag(TabBarSelectionView.start.rawValue)
                .environmentObject(viewModel)
            
            Text("Екран бізнес-плану")
                .tag(TabBarSelectionView.plans.rawValue)
            
            Text("Фінансовий трекер")
                .tag(TabBarSelectionView.tracker.rawValue)
            
            Text("Моделі масштабування")
                .tag(TabBarSelectionView.advices.rawValue)
            
            Text("Цілі та завдання")
                .tag(TabBarSelectionView.goals.rawValue)
                .environmentObject(viewModel)
        }
        .overlay {
            if viewModel.isShowTabBar {
                VStack {
                    Spacer()
                    TabBarCustomView(selectedItem: $viewModel.selection)
                        .frame(height: UIScreen.main.bounds.height * 0.1)
                }
                .ignoresSafeArea(edges: .bottom)
            }
        }
    }
}

#Preview {
    TabBar()
}
