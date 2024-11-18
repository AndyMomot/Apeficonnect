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
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
            
            Text(title)
                .foregroundStyle(.charcoalBlack)
                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
            
            Spacer()
            
            Button {
                action()
            } label: {
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.charcoalBlack)
                    .frame(width: 8, height: 14)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 5)
            }
        }
    }
}

#Preview {
    UserButton(image: Asset.share.swiftUIImage, title: "Share") {}
}
