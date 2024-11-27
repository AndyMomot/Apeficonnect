//
//  AddIncomeCostCategoryView.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 18.11.2024.
//

import SwiftUI

struct AddIncomeCostCategoryView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var text = ""
    
    var body: some View {
        ZStack {
            Colors.paleAsh.swiftUIColor
                .ignoresSafeArea()
            
            LiniarGradientView()
                .ignoresSafeArea()
                .opacity(0.3)
            
            ScrollView {
                BlurredContainerView {
                    VStack(spacing: 40) {
                        InputField(title: "Nazwa kategorii",
                                   placeholder: "Wprowadź nazwę...",
                                   text: $text)
                        
                        NextButton(title: "Ratować") {
                            saveCategory()
                        }
                        .frame(height: 58)
                        .disabled(text.isEmpty)
                    }
                }
                .padding(16)
            }
            .scrollIndicators(.hidden)
            .hideKeyboardWhenTappedAround()
        }
    }
}

private extension AddIncomeCostCategoryView {
    func saveCategory() {
        DispatchQueue.global().async {
            if !DefaultsService.shared.incomeCostCategories.contains(where: {$0.name == text}) {
                let category = IncomeCostCategoryModel(name: self.text)
                DefaultsService.shared.incomeCostCategories.append(category)
            }
            
            DispatchQueue.main.async {
                dismiss.callAsFunction()
            }
        }
    }
}

#Preview {
    AddIncomeCostCategoryView()
}
