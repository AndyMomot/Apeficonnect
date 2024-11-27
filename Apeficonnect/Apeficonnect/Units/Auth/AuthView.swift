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
            
            Asset.authLogo.swiftUIImage
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 60)
                .opacity(0.2)
            
            VStack(spacing: 57) {
                HStack {
                    Text("Cześć, Witamy!")
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 20))
                        .foregroundStyle(Color.dimGray)
                    Spacer()
                }
                
                InputField(title: "Przydomek",
                           placeholder: "Twój pseudonim",
                           text: $viewModel.nickName)
                
                Spacer()
                
                NextButton(title: "Następny") {
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
        .hideKeyboardWhenTappedAround()
    }
}

#Preview {
    AuthView()
}
