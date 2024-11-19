//
//  IncomeCostChartView.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 19.11.2024.
//

import SwiftUI
import Charts

struct IncomeCostChartView: View {
    var incomeItems: [Int]
    var costItems: [Int]
    
    @State private var income = 0
    @State private var cost = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Chart {
                
                
                ForEach(costItems.indices, id: \.self) { index in
                    let value = costItems[index]
                    BarMark(x: .value("index 1", index),
                             y: .value("value 1", value))
                    .foregroundStyle(.red)
                }
                
                ForEach(incomeItems.indices, id: \.self) { index in
                    let value = incomeItems[index]
                    BarMark(x: .value("index 2", index),
                             y: .value("value 2", value))
                    .foregroundStyle(.green)
                    .cornerRadius(10)
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            .chartXAxis(.hidden)
            
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
                        Text("\(income)".toNumberFormat())
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
                        Text("\(cost)".toNumberFormat())
                            .foregroundStyle(Color.dimGray)
                            .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 14))
                    }
                }
            }
        }
        .onAppear {
            income = reduce(array: incomeItems)
            cost = reduce(array: costItems)
        }
        .onChange(of: incomeItems) { array in
            income = reduce(array: array)
        }
        .onChange(of: costItems) { array in
            cost = reduce(array: array)
        }
    }
}

private extension IncomeCostChartView {
    func reduce(array: [Int]) -> Int {
        return array.reduce(0) {$0 + $1}
    }
}

#Preview {
    IncomeCostChartView(
        incomeItems: [1, 2, 6, 2, 6, 5, 1, 6],
        costItems: [1, 2, 6, 3, 3, 7, 7, 1, 4])
    .frame(width: 300, height: 200)
}
