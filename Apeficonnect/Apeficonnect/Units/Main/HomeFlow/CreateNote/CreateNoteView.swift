//
//  CreateNoteView.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 27.11.2024.
//

import SwiftUI

struct CreateNoteView: View {
    
    @StateObject private var viewModel = ViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Colors.paleAsh.swiftUIColor
                .ignoresSafeArea()
            
            VStack {
                Asset.addGoalBg.swiftUIImage
                    .resizable()
                    .scaledToFit()
                Spacer()
            }
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                HStack {
                    Button {
                        dismiss.callAsFunction()
                    } label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.white)
                            .frame(width: 8, height: 14)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 5)
                    }
                    
                    Spacer()
                    
                    Text("Nowa notatka")
                        .foregroundStyle(.white)
                        .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 20))
                }
                .padding(.horizontal, 16)
                
                ScrollView {
                    VStack(spacing: 20) {
                        BlurredContainerView {
                            VStack(spacing: 20) {
                                InputField(
                                    title: "Tytuł",
                                    placeholder: "Wprowadź tytuł...",
                                    text: $viewModel.title
                                )
                                
                                DynamicHeightTextField(
                                    title: "Opis",
                                    placeholder: "Wprowadź opis...",
                                    text: $viewModel.description
                                )
                                .frame(minHeight: 120)
                                
                                VStack(alignment: .leading) {
                                    HStack() {
                                        Text("Kategoria")
                                        
                                        Spacer()
                                        
                                        Button {
                                            withAnimation {
                                                viewModel.showAddCategory.toggle()
                                            }
                                        } label: {
                                            Image(systemName: "plus")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 24)
                                        }
                                    }
                                    .foregroundStyle(.dimGray)
                                    .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                                    
                                    if !viewModel.categories.isEmpty {
                                        MenuPicker(
                                            selectedItem: $viewModel.selectedCategory,
                                            items: viewModel.categories
                                        )
                                    }
                                }
                                
                                Spacer()
                                
                                NextButton(title: "Dodaj nową notatkę") {
                                    viewModel.saveNote {
                                        dismiss.callAsFunction()
                                    }
                                }
                                .frame(height: 59)
                                .padding(.vertical, 50)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .scrollIndicators(.never)
            }
            
            if viewModel.showAddCategory {
                AddCategoryView(
                    show: $viewModel.showAddCategory,
                    name: $viewModel.newCategoryName) {
                        viewModel.addCategory()
                    }
                    .ignoresSafeArea()
            }
        }
        .navigationBarBackButtonHidden()
        .hideKeyboardWhenTappedAround()
        .onAppear {
            withAnimation {
                viewModel.getCategories()
            }
        }
    }
}

#Preview {
    CreateNoteView()
}
