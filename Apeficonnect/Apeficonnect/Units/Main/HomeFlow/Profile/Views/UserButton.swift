//
//  UserButton.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 18.11.2024.
//

import SwiftUI

struct UserButton: View {
    var image: Image
    var title: String
    var action: () -> Void
    
    var body: some View {
        HStack(spacing: 30) {
            image
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white)
                .frame(width: 30, height: 30)
            
            Text(title)
                .foregroundStyle(.white)
                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
            
            Spacer()
            
            Button {
                action()
            } label: {
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.white)
                    .frame(width: 8, height: 14)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 5)
            }
        }
    }
}

#Preview {
    ZStack {
        Color.purple
        
        UserButton(image: Asset.share.swiftUIImage, title: "Share") {}
    }
}
