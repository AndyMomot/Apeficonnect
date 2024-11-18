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
        .init(imageName: Asset.startTab.name),
        .init(imageName: Asset.trackerTab.name),
        .init(imageName: Asset.advicesTab.name),
        .init(imageName: Asset.goalsTab.name)
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
            
            HStack {
                Spacer()
                ForEach(arrange, id: \.self) { index in
                    let item = items[index]
                    let isSelected = index == selectedItem
                    
                    Image(item.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 30)
                        .opacity(isSelected ? 1 : 0.5)
                        .onTapGesture {
                            withAnimation {
                                selectedItem = index
                            }
                        }
                    Spacer()
                }
            }
        }
        .overlay {
            RoundedRectangle(cornerRadius: 24)
                .stroke(LinearGradient(
                    gradient: Gradient(colors: [
                        Color.blue,
                        Color.purple,
                        Color.pink,
                        Color.orange]),
                    startPoint: .leading,
                    endPoint: .trailing
                ), lineWidth: 1)
               
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
