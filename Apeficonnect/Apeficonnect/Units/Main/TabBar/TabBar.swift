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
            
            FinanceTrackerView()
                .tag(TabBarSelectionView.tracker.rawValue)
            
            AdvicesView()
                .tag(TabBarSelectionView.advices.rawValue)
            
            GoalsView()
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
