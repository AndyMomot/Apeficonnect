//
//  CreateBicycleField.swift
//
//  Created by Andrii Momot on 26.10.2024.
//

import SwiftUI

struct InputField: View {
    var title: String
    var placeholder: String?
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .foregroundStyle(.dimGray)
                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
            
            TextField(text: $text) {
                if let placeholder {
                    Text(placeholder)
                        .foregroundStyle(.dimGray.opacity(0.5))
                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                }
            }
            .foregroundStyle(.dimGray)
            .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
            .padding(.horizontal, 12)
            .padding(.vertical, 26)
            .overlay {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.dimGray, lineWidth: 1)
            }
        }
    }
}

#Preview {
    InputField(title: "Typ",
               placeholder: "Type the text",
               text: .constant(""))
        .padding()
}
