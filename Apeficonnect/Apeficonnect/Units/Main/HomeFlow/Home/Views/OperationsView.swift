//
//  OperationsView.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 19.11.2024.
//

import SwiftUI

struct OperationsView: View {
    var items: [IncomeCostModel]
    
    var body: some View {
        BlurredContainerView {
            VStack(spacing: 10) {
                ForEach(items) { item in
                    OperationCell(item: item)
                }
            }
        }
    }
}

#Preview {
    OperationsView(items: [
        .init(
            category: .init(name: "Income from the sale of the product"),
            type: .income,
            amount: 6890
        ),
        .init(
            category: .init(name: "Rent"),
            type: .cost,
            amount: 2190
        )
    ])
    .padding()
}
