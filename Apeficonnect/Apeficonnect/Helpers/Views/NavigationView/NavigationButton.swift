//
//  NavigationButton.swift
//  Millvelorotour
//
//  Created by Andrii Momot on 25.10.2024.
//

import SwiftUI

struct NavigationButton: View {
    var imageName: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                Color.white
                Image(imageName)
            }
            .cornerRadius(8, corners: .allCorners)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.blue, lineWidth: 1)
            }
        }
        .frame(width: 36, height: 36)
    }
}

#Preview {
    ZStack {
        NavigationButton(imageName: "") {}
    }
}
