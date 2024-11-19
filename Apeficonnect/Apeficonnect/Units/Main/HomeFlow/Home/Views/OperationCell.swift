//
//  OperationCell.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 19.11.2024.
//

import SwiftUI

struct OperationCell: View {
    var item: IncomeCostModel
    
    var body: some View {
        var imageName: String {
            switch item.type {
            case .income:
                return Asset.income.name
            case .cost:
                return Asset.cost.name
            }
        }
        
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .padding(10)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.blue,
                                Color.purple,
                                Color.pink,
                                Color.orange]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .clipShape(Circle())
                    .frame(width: 40, height: 40)
                    .overlay {
                        Circle()
                            .stroke(.white, lineWidth: 1)
                    }
                
                HStack(alignment: .top, spacing: 10) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(item.category.name)
                            .foregroundStyle(Colors.charcoalBlack.swiftUIColor)
                            .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 10))
                        
                        Text(item.date.toString(format: .ddMMYYHHmm))
                            .foregroundStyle(Colors.charcoalBlack.swiftUIColor)
                            .font(Fonts.SFProDisplay.lightItalic.swiftUIFont(size: 8))
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 2) {
                        Text(item.type == .income ? "+" : "-")
                        Text("\(item.amount)".toNumberFormat())
                    }
                    .foregroundStyle(Colors.charcoalBlack.swiftUIColor)
                    .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 10))
                }
            }
            
            Rectangle()
                .fill(Colors.charcoalBlack.swiftUIColor)
                .frame(height: 1)
        }
    }
}

#Preview {
    ZStack {
        Color.pink.opacity(0.2)
        
        VStack {
            OperationCell(item: .init(
                category: .init(name: "Income from the sale of the product"),
                type: .income,
                amount: 6890
            ))
            
            OperationCell(item: .init(
                category: .init(name: "Rent"),
                type: .cost,
                amount: 2190
            ))
        }
        .padding()
    }
}
