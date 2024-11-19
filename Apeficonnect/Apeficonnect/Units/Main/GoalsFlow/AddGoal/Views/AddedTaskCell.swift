//
//  AddedTaskCell.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 19.11.2024.
//

import SwiftUI

struct AddedTaskCell: View {
    var name: String
    var onDelete: (String) -> Void
    
    var body: some View {
        HStack {
            Text(name)
                .foregroundStyle(Color.dimGray)
                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 16))
            Spacer()
            Button {
                onDelete(name)
            } label: {
                Image(systemName: "xmark")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Color.dimGray)
                    .frame(width: 12, height: 12)
                    .padding(.vertical, 12)
                    .padding(.leading, 12)
            }

        }
    }
}

#Preview {
    AddedTaskCell(name: "Task 1") {_ in}
        .padding()
}
