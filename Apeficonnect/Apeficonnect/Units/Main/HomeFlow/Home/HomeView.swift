//
//  HomeView.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 18.11.2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
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
                        
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .hidden()
                    }
                    
                    ScrollView {
                        
                    }
                    .scrollIndicators(.hidden)
                }
                .padding(.horizontal, 16)
            }
            .navigationDestination(isPresented: $viewModel.showProfile) {
                ProfileView()
            }
        }
    }
}

#Preview {
    HomeView()
}
