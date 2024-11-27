//
//  AdvicesView.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 19.11.2024.
//

import SwiftUI

struct AdvicesView: View {
    @StateObject private var viewModel = ViewModel()
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Asset.homeBg.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            
            Color.purpleCustom.opacity(0.2)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                NavigationTitleView()
                
                ScrollView {
                    VStack(spacing: 20) {
                        HStack {
                            Text("Modele skalowania")
                                .foregroundStyle(.white)
                                .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 20))
                            Spacer()
                        }
                        
                        if viewModel.selectedStrategy == nil {
                            HStack {
                                Text("Wybierz jedną ze strategii, aby przewidzieć jej wyniki i ryzyko.")
                                    .foregroundStyle(.white)
                                    .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 14))
                                Spacer()
                            }
                        }
                        
                        HStack {
                            ForEach(viewModel.strategyItems, id: \.id) { item in
                                let isSelected = item.id == viewModel.selectedStrategy?.id
                                StrategyCell(
                                    image: item.image,
                                    title: item.title,
                                    isSelected: isSelected
                                )
                                .onTapGesture {
                                    withAnimation(.snappy()) {
                                        if isSelected {
                                            viewModel.selectedStrategy = nil
                                        } else {
                                            viewModel.selectedStrategy = item
                                        }
                                    }
                                }
                            }
                            .frame(height: bounds.width * 0.363)
                        }
                        
                        if let selectedStrategy = viewModel.selectedStrategy {
                            StrategyInfoView(
                                header: selectedStrategy.header,
                                text: selectedStrategy.text
                            )
                        } else {
                            StrategyPreview()
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, bounds.height * 0.1)
                }
                .scrollIndicators(.never)
            }
        }
    }
}

#Preview {
    AdvicesView()
}
