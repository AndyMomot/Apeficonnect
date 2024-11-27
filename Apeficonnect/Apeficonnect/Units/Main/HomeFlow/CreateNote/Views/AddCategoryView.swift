//
//  AddCategoryView.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 27.11.2024.
//

import SwiftUI

struct AddCategoryView: View {
    @Binding var show: Bool
    @Binding var name: String
    var onSave: () -> Void
    
    var body: some View {
        ZStack {
            Color.white.opacity(0.8)
                .ignoresSafeArea()
            
            VStack {
                BlurredContainerView {
                    VStack(spacing: 20) {
                        InputField(title: "Name",
                                   placeholder: "Enter new category name",
                                   text: $name
                        )
                        
                        NextButton(title: "Save") {
                            if !name.isEmpty {
                                onSave()
                                withAnimation {
                                    show = false
                                }
                            }
                        }
                        .frame(height: 55)
                        
                        Button {
                            withAnimation {
                                show = false
                            }
                        } label: {
                            Text("Close")
                                .foregroundStyle(.dimGray)
                                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                        }
                    }
                }
                .padding(.vertical, 100)
                .padding(.horizontal)
                
                Spacer()
            }
        }
    }
}

#Preview {
    AddCategoryView(show: .constant(true),
                    name: .constant("")) {
        
    }
}
