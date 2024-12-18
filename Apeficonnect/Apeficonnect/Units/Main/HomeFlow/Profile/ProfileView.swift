//
//  ProfileView.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 18.11.2024.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ViewModel()
    @EnvironmentObject private var tabBarVM: TabBar.TabBarViewModel
    @EnvironmentObject private var rootVM: RootContentView.RootContentViewModel
    @Environment(\.dismiss) private var dismiss
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Asset.homeBg.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            
            Color.purpleCustom.opacity(0.2)
                .ignoresSafeArea()
            
            VStack(spacing: 60) {
                VStack(spacing: 0) {
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
                    }
                    
                    HStack(alignment: .bottom) {
                        Rectangle()
                            .frame(width: 24, height: 24)
                            .hidden()
                        
                        Spacer()
                        
                        Button {
                            DispatchQueue.main.async {
                                viewModel.showImagePicker.toggle()
                            }
                        } label: {
                            Image(uiImage: viewModel.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: bounds.width * 0.4, height: bounds.width * 0.4)
                                .clipShape(Circle())
                        }
                        .disabled(!viewModel.canEdit)
                        
                        Spacer()
                        
                        Button {
                            viewModel.canEdit.toggle()
                        } label: {
                            Image(systemName: viewModel.canEdit ? "pencil.circle.fill" : "pencil.circle")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(Color.purpleCustom, .white)
                                .frame(width: 28, height: 28)
                                .shadow(color: .black,
                                        radius: 10)
                        }
                    }
                }
                
                ScrollView {
                    BlurredContainerView {
                        VStack(spacing: 24) {
                            HStack(spacing: 30) {
                                Asset.person.swiftUIImage
                                    .renderingMode(.template)
                                    .resizable()
                                    .foregroundStyle(.white)
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                
                                TextField(text: $viewModel.nickName) {
                                    Text("Wprowadź swój pseudonim")
                                        .foregroundStyle(.white.opacity(0.5))
                                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                                }
                                .foregroundStyle(.white)
                                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                                .disabled(!viewModel.canEdit)
                                
                                Spacer()
                            }
                            
                            if let url = URL(string: viewModel.appUrl) {
                                UserButton(
                                    image: Asset.share.swiftUIImage,
                                    title: "Udział") {
                                        DispatchQueue.main.async {
                                            share(url: url.absoluteString)
                                        }
                                    }
                                
                                UserButton(
                                    image: Asset.rate.swiftUIImage,
                                    title: "Oceń aplikację") {
                                        DispatchQueue.main.async {
                                            UIApplication.shared.open(url)
                                        }
                                    }
                            }
                            
                            UserButton(
                                image: Image(systemName: "arrow.up.trash.fill"),
                                title: "Wyczyść pamięć podręczną") {
                                    withAnimation {
                                        viewModel.showClearCacheAlert = true
                                    }
                                }
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
            .padding(.horizontal, 24)
            
            if viewModel.showLoader {
                ProgressView()
            }
        }
        .alert("Usuwanie danych", isPresented: $viewModel.showClearCacheAlert) {
            Button("Anulować", role: .cancel) {}
            
            Button("Usuwać", role: .destructive) {
                withAnimation { viewModel.showLoader = true }
                viewModel.clearCache {
                    withAnimation {
                        viewModel.showLoader = false
                        rootVM.setFlow(.onboarding)
                    }
                }
            }
        } message: {
            Text("Czy na pewno chcesz usunąć dane?")
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            withAnimation {
                viewModel.getUser()
                tabBarVM.showTabBar(false)
            }
        }
        .onDisappear {
            viewModel.saveUserImage()
            withAnimation {
                tabBarVM.showTabBar(true)
            }
        }
        .sheet(isPresented: $viewModel.showImagePicker) {
            ImagePicker(selectedImage: $viewModel.image)
        }
        .onChange(of: viewModel.nickName) { _ in
            viewModel.saveNickname()
        }
    }
}

#Preview {
    ProfileView()
}
