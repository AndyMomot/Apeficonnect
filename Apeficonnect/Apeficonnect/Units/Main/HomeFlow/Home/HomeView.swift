//
//  HomeView.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 18.11.2024.
//

import SwiftUI
import Charts

struct HomeView: View {
    @StateObject private var viewModel = ViewModel()
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Asset.homeBg.swiftUIImage
                        .resizable()
                        .scaledToFit()
                    Spacer()
                }
                .ignoresSafeArea()
                
                Color.purpleCustom.opacity(0.2)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    HStack(spacing: 20) {
                        Button {
                            viewModel.showProfile.toggle()
                        } label: {
                            Asset.person.swiftUIImage
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(.white)
                        }
                        
                        NavigationTitleView()
                        
                        Button {
                            viewModel.showAddNote.toggle()
                        } label: {
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.white)
                                .frame(width: 24, height: 24)
                        }
                    }
                    
                    ScrollView {
                        VStack(spacing: 20) {
                            HStack {
                                Text("Notes")
                                    .foregroundStyle(.white)
                                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 20))
                                Spacer()
                            }
                            
                            BlurredContainerView {
                                VStack(spacing: 20) {
                                    HStack {
                                        if !viewModel.sortList.isEmpty {
                                            MenuPicker(
                                                selectedItem: $viewModel.selectedSortItem,
                                                items: viewModel.sortList)
                                            .frame(width: bounds.width * 0.3)
                                        }
                                        
                                        Spacer()
                                        
                                        if !viewModel.categoryList.isEmpty {
                                            MenuPicker(
                                                selectedItem: $viewModel.selectedCategory,
                                                items: viewModel.categoryList)
                                            .frame(width: bounds.width * 0.3)
                                        }
                                    }
                                    
                                    if viewModel.notes.isEmpty {
                                        Text("Nie znaleziono wpisów")
                                            .foregroundStyle(.white)
                                            .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 20))
                                            .multilineTextAlignment(.center)
                                    } else {
                                        VStack(spacing: 10) {
                                            ForEach(viewModel.notes) { note in
                                                NoteView(item: note)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.bottom, bounds.height * 0.1)
                    }
                    .scrollIndicators(.hidden)
                }
                .padding(.horizontal, 16)
            }
            .onAppear {
                viewModel.getCategories()
                viewModel.getNotes()
            }
            .onChange(of: viewModel.selectedSortItem) { _ in
                viewModel.getNotes()
            }
            .onChange(of: viewModel.selectedCategory) { _ in
                viewModel.getNotes()
            }
            .navigationDestination(isPresented: $viewModel.showProfile) {
                ProfileView()
            }
            .navigationDestination(isPresented: $viewModel.showAddNote) {
                CreateNoteView()
            }
        }
    }
}

#Preview {
    HomeView()
}
