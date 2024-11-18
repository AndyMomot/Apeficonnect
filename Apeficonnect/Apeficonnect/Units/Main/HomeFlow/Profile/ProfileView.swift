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
    @Environment(\.dismiss) private var dismiss
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Color.paleAsh
                .ignoresSafeArea()
            
            VStack {
                Asset.homeBg.swiftUIImage
                    .resizable()
                    .scaledToFit()
                Spacer()
            }
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
                        Image(systemName: viewModel.canEdit ? "pencil.circle.fill" : "pencil.circle")
                            .resizable()
                            .scaledToFit()
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
                                .foregroundStyle(Color.dimGray)
                                .frame(width: 24, height: 24)
                        }
                    }
                }
                
                ScrollView {
                    BlurredContainerView {
                        VStack(spacing: 24) {
                            HStack(spacing: 30) {
                                Asset.person.swiftUIImage
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                
                                TextField(text: $viewModel.nickName) {
                                    Text("Enter your nickname")
                                        .foregroundStyle(.charcoalBlack.opacity(0.5))
                                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                                }
                                .foregroundStyle(.charcoalBlack)
                                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                                .disabled(!viewModel.canEdit)
                                
                                Spacer()
                            }
                            
                            if let url = URL(string: viewModel.appUrl) {
                                UserButton(
                                    image: Asset.share.swiftUIImage,
                                    title: "Share") {
                                        DispatchQueue.main.async {
                                            share(url: url.absoluteString)
                                        }
                                    }
                                
                                UserButton(
                                    image: Asset.rate.swiftUIImage,
                                    title: "Rate the App") {
                                        DispatchQueue.main.async {
                                            UIApplication.shared.open(url)
                                        }
                                    }
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
            .padding(.horizontal, 24)
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
