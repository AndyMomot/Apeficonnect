//
//  HomeView.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 18.11.2024.
//

import SwiftUI
import Charts

struct HomeView: View {
    @StateObject private var viewModel = ViewModel()
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.paleAsh
                    .ignoresSafeArea()
                
                VStack {
                    Asset.homeBg.swiftUIImage
                        .resizable()
                        .scaledToFit()
                    Spacer()
                }
                .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    HStack(spacing: 20) {
                        Button {
                            viewModel.showProfile.toggle()
                        } label: {
                            Asset.person.swiftUIImage
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(.white)
                        }
                        
                        NavigationTitleView()
                        
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .hidden()
                    }
                    
                    ScrollView {
                        VStack(spacing: 20) {
                            HStack {
                                Text("Income and Expenditure Statistics for the Period")
                                    .foregroundStyle(.white)
                                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 20))
                                Spacer()
                            }
                            
                            BlurredContainerView {
                                VStack(spacing: 20) {
                                    HStack {
                                        MenuPicker(
                                            selectedItem: $viewModel.selectedYear,
                                            items: viewModel.yearsList)
                                        .frame(width: bounds.width * 0.3)
                                        
                                        Spacer()
                                        
                                        MenuPicker(
                                            selectedItem: $viewModel.selectedMonth,
                                            items: viewModel.monthList)
                                        .frame(width: bounds.width * 0.3)
                                    }
                                    
                                    if viewModel.incomeItems.isEmpty && viewModel.costItems.isEmpty {
                                        Text("No data")
                                    } else {
                                        IncomeCostChartView(
                                            incomeItems: viewModel.incomeItems,
                                            costItems: viewModel.costItems
                                        )
                                    }
                                }
                            }
                            
                            if !viewModel.incomeCostItems.isEmpty {
                                OperationsView(items: viewModel.incomeCostItems)
                            }
                        }
                        .padding(.bottom, bounds.height * 0.1)
                    }
                    .scrollIndicators(.hidden)
                }
                .padding(.horizontal, 16)
            }
            .onAppear {
                viewModel.setInitialPickerValue()
                viewModel.getItems()
            }
            .onChange(of: viewModel.selectedMonth) { _ in
                viewModel.getItems()
            }
            .onChange(of: viewModel.selectedYear) { _ in
                viewModel.getItems()
            }
            .navigationDestination(isPresented: $viewModel.showProfile) {
                ProfileView()
            }
        }
    }
}

#Preview {
    HomeView()
}
