//
//  FinanceTrackerView.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 18.11.2024.
//

import SwiftUI
import Charts

struct FinanceTrackerView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                Asset.financeTrackerBg.swiftUIImage
                    .resizable()
                    .scaledToFit()
                
                Spacer()
                
                Asset.financeTrackerBottomBg.swiftUIImage
                    .resizable()
                    .scaledToFit()
                
                Spacer()
            }
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                NavigationTitleView()
                
                HStack {
                    Text("Financial tracker")
                        .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 20))
                        .foregroundStyle(Color.dimGray)
                    Spacer()
                }
                
                ScrollView {
                    BlurredContainerView {
                        if !viewModel.incomeItems.isEmpty || !viewModel.costItems.isEmpty {
                            Chart {
                                ForEach(viewModel.incomeItems.indices,
                                        id: \.self) { index in
                                    let value = viewModel.incomeItems[index]
                                    PointMark(x: .value("index", index),
                                              y: .value("value", value))
                                    .foregroundStyle(.green)
                                }
                                
                                ForEach(viewModel.incomeItems.indices, id: \.self) { index in
                                    let value = viewModel.incomeItems[index]
                                    LineMark(x: .value("index 1", index),
                                             y: .value("value 1", value),
                                             series: .value("Income", "A"))
                                    .foregroundStyle(.green)
                                }
                                
                                ForEach(viewModel.costItems.indices,
                                        id: \.self) { index in
                                    let value = viewModel.costItems[index]
                                    PointMark(x: .value("index", index),
                                              y: .value("value", value))
                                    .foregroundStyle(.red)
                                }
                                
                                ForEach(viewModel.costItems.indices, id: \.self) { index in
                                    let value = viewModel.costItems[index]
                                    LineMark(x: .value("index 1", index),
                                             y: .value("value 1", value),
                                             series: .value("Cost", "B"))
                                    .foregroundStyle(.red)
                                }
                            }
                            .chartYAxis {
                                AxisMarks(position: .leading)
                            }
                            .chartXAxis(.hidden)
                            .padding(.bottom)
                        }
                        
                        VStack(spacing: 20) {
                            HStack(spacing: 20) {
                                // Income
                                HStack(spacing: 8) {
                                    Circle()
                                        .fill(.green)
                                        .frame(width: 12)
                                    HStack(spacing: 5) {
                                        Text("Income:")
                                            .foregroundStyle(Color.dimGray)
                                            .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 14))
                                        Text("\(viewModel.income)".toNumberFormat())
                                            .foregroundStyle(Color.dimGray)
                                            .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 14))
                                    }
                                }
                                
                                // Cost
                                HStack(spacing: 8) {
                                    Circle()
                                        .fill(.red)
                                        .frame(width: 12)
                                    HStack(spacing: 4) {
                                        Text("Cost:")
                                            .foregroundStyle(Color.dimGray)
                                            .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 14))
                                        Text("\(viewModel.cost)".toNumberFormat())
                                            .foregroundStyle(Color.dimGray)
                                            .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 14))
                                    }
                                }
                            }
                            
                            Button {
                                withAnimation {
                                    viewModel.showAddItem.toggle()
                                }
                            } label: {
                                HStack {
                                    Text("Adding New Item")
                                    Spacer()
                                    Image(systemName: viewModel.showAddItem ? "chevron.up" : "chevron.down")
                                        .padding(.vertical, 6)
                                }
                                .foregroundStyle(Color.dimGray)
                                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 12))
                            }
                            
                            if viewModel.showAddItem {
                                // Categories
                                IncomeCategoryList(items: viewModel.categories) { action in
                                    viewModel.handleCategoryList(action: action)
                                }
                                
                                IncomeCategoryTypeList { type in
                                    viewModel.selectedType = type
                                }
                                
                                InputField(title: "Amount",
                                           placeholder: "00",
                                           text: $viewModel.amount)
                                .keyboardType(.numberPad)
                                
                                // Save button
                                HStack(spacing: 0) {
                                    Button {
                                        viewModel.saveItem()
                                    } label: {
                                        HStack {
                                            Spacer()
                                            Text("Add New Item")
                                                .lineLimit(1)
                                                .foregroundStyle(.white)
                                                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 12))
                                                .padding(.vertical, 16)
                                            Spacer()
                                        }
                                        .padding(.horizontal, 26)
                                        .background(
                                            LiniarGradientView()
                                        )
                                        .cornerRadius(30, corners: .allCorners)
                                    }
                                }
                            }
                        }
                        .padding(.bottom, 60)
                    }
                    .padding(.bottom, UIScreen.main.bounds.height * 0.1)
                }
                .scrollIndicators(.hidden)
            }
            .padding(.horizontal, 16)
        }
        .hideKeyboardWhenTappedAround()
        .onAppear {
            viewModel.getItems()
            viewModel.getCategories()
        }
        .sheet(isPresented: $viewModel.showAddCategory) {
            viewModel.getCategories()
        } content: {
            AddIncomeCostCategoryView()
        }

    }
}

#Preview {
    FinanceTrackerView()
}
