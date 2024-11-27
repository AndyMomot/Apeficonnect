//
//  TabBarCustomView.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 13.06.2024.
//

import SwiftUI

struct TabBarCustomView: View {
    @Binding var selectedItem: Int
    
    @State private var items: [TabBar.Item] = [
        .init(imageName: Asset.startTab.name, color: .purple),
        .init(imageName: Asset.trackerTab.name, color: .blue),
        .init(imageName: Asset.advicesTab.name, color: .teal),
        .init(imageName: Asset.goalsTab.name, color: .green)
    ]
    
    private var arrange: [Int] {
        Array(0..<items.count)
    }
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        let arrange = (0..<items.count)
        
        ZStack {
            Color.white
                .cornerRadius(24, corners: [.topLeft, .topRight])
            
            HStack(spacing: 0) {
                ForEach(arrange, id: \.self) { index in
                    let item = items[index]
                    let isSelected = index == selectedItem
                    var cornerRadius: CGFloat {
                        if index == 0 || index == arrange.count - 1 {
                            return 24
                        } else {
                            return 0
                        }
                    }
                    var corners: UIRectCorner {
                        if index == 0 {
                            return .topLeft
                        } else if index == arrange.count - 1 {
                            return .topRight
                        } else {
                            return []
                        }
                    }
                    
                    ZStack {
                        item.color
                            .cornerRadius(cornerRadius,
                                          corners: corners)
                        
                        Image(item.imageName)
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.white)
                            .frame(maxWidth: 30)
                    }
                    .opacity(isSelected ? 1 : 0.7)
                    .onTapGesture {
                        withAnimation {
                            selectedItem = index
                        }
                    }
                }
            }
        }
        .overlay {
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.purpleCustom, lineWidth: 1)
               
        }
    }
}

#Preview {
    ZStack {
        Color.gray
        
        VStack {
            Spacer()
            TabBarCustomView(selectedItem: .constant(0))
                .frame(height: 100)
        }
        .ignoresSafeArea()
    }
}
