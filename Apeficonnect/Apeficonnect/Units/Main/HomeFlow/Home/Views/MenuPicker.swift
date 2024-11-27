//
//  MenuPicker.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 19.11.2024.
//

import SwiftUI

struct MenuPicker: View {
    @Binding var selectedItem: String
    var items: [String]
    
    var body: some View {
        Menu {
            ForEach(items, id: \.self) { item in
                let isSelected = item == selectedItem
                
                Button {
                    selectedItem = item
                } label: {
                    HStack {
                        if isSelected {
                            Image(systemName: "checkmark")
                        }
                        
                        Text("\(String(describing: item))")
                            .foregroundStyle(Colors.charcoalBlack.swiftUIColor)
                            .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 14))
                    }
                }
            }
        } label: {
            HStack(spacing: 0) {
                Text("\(String(describing: selectedItem))")
                    .foregroundStyle(Colors.charcoalBlack.swiftUIColor)
                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 14))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                
                Spacer(minLength: 10)
                
                Image(systemName: "triangleshape.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Colors.charcoalBlack.swiftUIColor)
                    .frame(width: 9, height: 9)
                    .rotationEffect(.degrees(180))
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 8)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Colors.charcoalBlack.swiftUIColor,
                            lineWidth: 1)
            }
        }

    }
}

#Preview {
    MenuPicker(selectedItem: .constant("Item 1"), items: [
        "Item 1", "Item 2", "Item 3"
    ])
    .frame(width: 110)
}
