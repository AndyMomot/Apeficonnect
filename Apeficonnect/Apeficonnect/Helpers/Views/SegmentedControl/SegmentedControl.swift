//
//  SegmentedControl.swift
//  Millvelorotour
//
//  Created by Andrii Momot on 27.10.2024.
//

import SwiftUI

struct SegmentedControl: View {
    var items: [String]
    var accentColor: Color = .blue
    var secondaryColor: Color = .gray
    @Binding var selectedIndex: Int
    
    var body: some View {
        HStack(spacing: 20) {
            ForEach((0..<items.count), id: \.self) { index in
                let item = items[index]
                let isSelected = selectedIndex == index
                
                Button {
                    DispatchQueue.main.async {
                        withAnimation(.easeInOut(duration: 0.1)) {
                            selectedIndex = index
                        }
                    }
                } label: {
                    VStack(spacing: 15) {
                        Text(item)
                            .foregroundStyle(
                                isSelected ? accentColor : secondaryColor
                            )
                        
                        Rectangle()
                            .foregroundStyle(accentColor)
                            .opacity(isSelected ? 1 : 0)
                            .frame(height: 2)
                    }
                }
            }
        }
    }
}

#Preview {
    SegmentedControl(
        items: ["Item 1", "Item 2"],
        selectedIndex: .constant(0)
    )
}
