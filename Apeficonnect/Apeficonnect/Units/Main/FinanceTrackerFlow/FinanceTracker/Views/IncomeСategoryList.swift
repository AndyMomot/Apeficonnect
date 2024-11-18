//
//  IncomeCategoryList.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 18.11.2024.
//

import SwiftUI

struct IncomeCategoryList: View {
    var items: [IncomeCostCategoryModel]
    var action: (ViewAction) -> Void
    
    @State private var selectedItem: IncomeCostCategoryModel?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Сategory")
                .multilineTextAlignment(.leading)
                .foregroundStyle(Colors.charcoalBlack.swiftUIColor)
            
            VStack(alignment: .leading, spacing: 12) {
                if !items.isEmpty {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 6) {
                            ForEach(items) { item in
                                Button {
                                    action(.onSelect(item: item))
                                    withAnimation(.linear(duration: 0.1)) {
                                        selectedItem = item
                                    }
                                } label: {
                                    HStack(spacing: 8) {
                                        let isSelected = selectedItem?.id == item.id
                                        
                                        if isSelected {
                                            Circle()
                                                .fill(Colors.charcoalBlack.swiftUIColor)
                                                .frame(width: 12)
                                        } else {
                                            Circle()
                                                .stroke(Colors.charcoalBlack.swiftUIColor, lineWidth: 1)
                                                .frame(width: 12)
                                        }
                                        
                                        Text(item.name)
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
                    .frame(maxHeight: 150)
                }
                
                Button {
                    action(.onAddNew)
                } label: {
                    HStack(spacing: 8) {
                        Text("+ New category")
                            .multilineTextAlignment(.leading)
                            .foregroundStyle(Colors.charcoalBlack.swiftUIColor)
                            .font(Fonts.SFProDisplay.semiboldItalic.swiftUIFont(size: 12))
                            .padding(.vertical, 6)
                        Spacer()
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

extension IncomeCategoryList {
    enum ViewAction {
        case onSelect(item: IncomeCostCategoryModel)
        case onAddNew
    }
}

#Preview {
    IncomeCategoryList(items: [
        .init(name: "Income From Product Sales"),
        .init(name: "Investment Income"),
        .init(name: "Franchise Royalties and Licensing Income"),
        .init(name: "Additional Income"),
        .init(name: "Partnerships and Joint Ventures")
    ]) {_ in}
        .padding()
}
