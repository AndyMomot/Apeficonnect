//
//  BackButton.swift
//  Libarorent
//
//  Created by Andrii Momot on 07.10.2024.
//

import SwiftUI

struct BackButton: View {
    var title: String
    var action: (() -> Void)?
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button {
            action?()
            dismiss.callAsFunction()
        } label: {
            HStack(spacing: 25) {
                Image(systemName: "chevron.left")
                Text(title)
                    .lineLimit(1)
                    .minimumScaleFactor(0.6)
                Spacer()
            }
            .foregroundStyle(.white)
            .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 30))
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ZStack {
       
        BackButton(title: "Telefony") {}
    }
}
