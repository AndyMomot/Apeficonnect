//
//  IncomeCategoryTypeList.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 18.11.2024.
//

import SwiftUI

struct IncomeCategoryTypeList: View {
    
    var items = IncomeCostType.allCases
    var action: (IncomeCostType) -> Void
    
    @State private var selectedItem: IncomeCostType?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Typ")
                .multilineTextAlignment(.leading)
                .foregroundStyle(Colors.charcoalBlack.swiftUIColor)
            
            VStack(alignment: .leading, spacing: 12) {
                
                VStack(alignment: .leading, spacing: 6) {
                    ForEach(items, id: \.rawValue) { item in
                        Button {
                            action(item)
                            withAnimation(.linear(duration: 0.1)) {
                                selectedItem = item
                            }
                        } label: {
                            HStack(spacing: 8) {
                                let isSelected = selectedItem?.rawValue == item.rawValue
                                
                                if isSelected {
                                    Circle()
                                        .fill(Colors.charcoalBlack.swiftUIColor)
                                        .frame(width: 12)
                                } else {
                                    Circle()
                                        .stroke(Colors.charcoalBlack.swiftUIColor, lineWidth: 1)
                                        .frame(width: 12)
                                }
                                
                                Text(item.rawValue)
                                    .multilineTextAlignment(.leading)
                                    .foregroundStyle(Colors.charcoalBlack.swiftUIColor)
                                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 12))
                                    .padding(.vertical, 6)
                                Spacer()
                            }
                        }
                    }
                }
            }
            .padding(16)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Colors.charcoalBlack.swiftUIColor, lineWidth: 1)
            }
            .padding(1)
        }
    }
}

#Preview {
    IncomeCategoryTypeList() {_ in}
        .padding()
}
