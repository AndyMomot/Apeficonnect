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
//
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
                            
                            
                            HStack(spacing: 0) {
                                Button {
                                    
                                } label: {
                                    Text("Add New Income")
                                        .lineLimit(1)
                                        .foregroundStyle(.white)
                                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 12))
                                        .padding(.horizontal, 26)
                                        .padding(.vertical, 16)
                                        .background(.green)
                                        .cornerRadius(30, corners: .allCorners)
                                }
                                
                                Spacer(minLength: 15)

                                Button {
                                    
                                } label: {
                                    Text("Add New Cost")
                                        .lineLimit(1)
                                        .foregroundStyle(.white)
                                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 12))
                                        .padding(.horizontal, 26)
                                        .padding(.vertical, 16)
                                        .background(.red)
                                        .cornerRadius(30, corners: .allCorners)
                                }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    FinanceTrackerView()
}
