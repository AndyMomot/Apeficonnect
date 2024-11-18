//
//  AuthView.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 17.11.2024.
//

import SwiftUI

struct AuthView: View {
    @StateObject private var viewModel = ViewModel()
    @EnvironmentObject private var rootViewModel: RootContentView.RootContentViewModel
    
    var body: some View {
        ZStack {
            Color.paleAsh
                .ignoresSafeArea()
            
            Asset.logo.swiftUIImage
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 60)
                .opacity(0.2)
            
            VStack(spacing: 57) {
                HStack {
                    Text("Hello, Welcome!")
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 20))
                        .foregroundStyle(Color.dimGray)
                    Spacer()
                }
                
                InputField(title: "Nickname",
                           placeholder: "Your Nickname",
                           text: $viewModel.nickName)
                
                Spacer()
                
                NextButton(title: "Next") {
                    viewModel.saveUser {
                        DispatchQueue.main.async {
                            rootViewModel.setFlow(.main)
                        }
                    }
                }
                .frame(height: 52)
                .disabled(viewModel.nickName.isEmpty)
                
                Spacer()
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    AuthView()
}
