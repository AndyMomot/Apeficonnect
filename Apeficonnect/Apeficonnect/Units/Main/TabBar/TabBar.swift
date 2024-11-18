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
        UITabBar.appearance().barTintColor = .clear
    }
    
    var body: some View {
            TabView(selection: $viewModel.selection) {
                HomeView()
                    .tag(TabBarSelectionView.start.rawValue)
                    .environmentObject(viewModel)
                
                Text("Фінансовий трекер")
                    .tag(TabBarSelectionView.tracker.rawValue)
                
                Text("Моделі масштабування")
                    .tag(TabBarSelectionView.advices.rawValue)
                
                VStack {
                    Text("Цілі та завдання")
                    
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(0..<10) { _ in
                                Rectangle()
                                    .frame(height: 80)
                            }
                        }
                    }
                }
                .tag(TabBarSelectionView.goals.rawValue)
                .environmentObject(viewModel)
            }
            .overlay {
                if viewModel.isShowTabBar {
                    VStack {
                        Spacer()
                        TabBarCustomView(selectedItem: $viewModel.selection)
                            .frame(height: UIScreen.main.bounds.height * 0.095)
                    }
                    .ignoresSafeArea(edges: .bottom)
                }
            }
    }
}

#Preview {
    TabBar()
}
