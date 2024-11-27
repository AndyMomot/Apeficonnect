//
//  NoteView.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 27.11.2024.
//

import SwiftUI

struct NoteView: View {
    var item: NoteModel
    
    init(item: NoteModel) {
        self.item = item
    }
    
    @State private var showText = false
    
    var body: some View {
        BlurredContainerView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .top) {
                        Text(item.title)
                            .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 20))
                        Spacer()
                        
                        Button {
                            DispatchQueue.main.async {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    showText.toggle()
                                }
                            }
                        } label: {
                            Image(systemName: showText ? "text.document.fill" : "text.document")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24)
                        }
                    }
                    .foregroundStyle(.dimGray)
                    
                    Text(item.category)
                        .foregroundStyle(.dimGray.opacity(0.6))
                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                }
                
                if showText {
                    Text(item.text)
                        .foregroundStyle(.dimGray)
                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 18))
                }
            }
        }
    }
}

#Preview {
    NoteView(item: .init(
        title: "Note title",
        text: "Note description description description descrip, description description, description.",
        category: "Category 1"
    ))
    .padding()
}
