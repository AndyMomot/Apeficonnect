//
//  OnboardingView.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 12.06.2024.
//

import SwiftUI

struct OnboardingView: View {
    var item: OnboardingView.OnboardingItem
    @Binding var currentPageIndex: Int
    
    @EnvironmentObject private var rootViewModel: RootContentView.RootContentViewModel
    @StateObject private var viewModel = OnboardingViewModel()
    
    var body: some View {
        ZStack {
            Color.paleAsh
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                if item != .third {
                    HStack {
                        Spacer()
                        Button {
                            currentPageIndex = OnboardingView.OnboardingItem.third.rawValue
                        } label: {
                            Text("Pominąć")
                                .foregroundStyle(.dimGray)
                                .padding(.vertical, 12)
                                .padding(.horizontal, 6)
                        }
                    }
                }
                
                VStack(spacing: 40) {
                    Image(item.image)
                        .resizable()
                        .scaledToFit()
                    
                    Text(item.text)
                        .lineSpacing(5)
                        .foregroundStyle(Color.dimGray)
                        .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 14))
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
                
                HStack(spacing: 10) {
                    ForEach(0..<3, id: \.self) { index in
                        if index <= item.rawValue  {
                            Circle()
                                .fill(Color.purpleCustom)
                                .frame(width: 17)
                        } else {
                            Circle()
                                .stroke(Color.purpleCustom, lineWidth: 1)
                                .frame(width: 17)
                        }
                    }
                }
                
                Spacer()
               
                if item == .third {
                    VStack(spacing: 16) {
                        NextButton(title: "Kontynuacja") {
                            withAnimation {
                                currentPageIndex = item.next.rawValue
                            }
                            
                            if item == .third {
                                viewModel.showAuth.toggle()
                            }
                        }
                        .frame(height: 48)
                        
                        Button {
                            viewModel.showPrivacyPolicy.toggle()
                        } label: {
                            HStack(spacing: 3) {
                                Text("Wybrałem „Start” Zgadzam się z")
                                    .foregroundStyle(.dimGray)
                                    .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 14))
                                
                                Text("Polityką Prywatności")
                                    .foregroundStyle(Color.purpleCustom)
                                    .underline().font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 14))
                            }
                        }
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal, 26)
        }
        .sheet(isPresented: $viewModel.showPrivacyPolicy) {
            SwiftUIViewWebView(url: viewModel.privacyPolicyURL)
        }
        .fullScreenCover(isPresented: $viewModel.showAuth) {
            AuthView()
        }
    }
}

#Preview {
    OnboardingView(item: .third, currentPageIndex: .constant(2))
}
