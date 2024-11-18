//
//  NavigationTitleView.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 18.11.2024.
//

import SwiftUI

struct NavigationTitleView: View {
    @State private var nickName = "User"
    
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 1) {
                Text("Hello, \(nickName)")
                    .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 12))
                    .foregroundStyle(.white)
                
                if let regionCode = Locale.current.region?.identifier,
                   let regionName = Locale.current.localizedString(forRegionCode: regionCode) {
                    Text(regionName)
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 12))
                        .foregroundStyle(.white)
                }
            }
            .multilineTextAlignment(.center)
            
            Spacer()
        }
        .onAppear {
            DispatchQueue.global().async {
                if let nickName = DefaultsService.shared.user?.nickName {
                    DispatchQueue.main.async {
                        self.nickName = nickName
                    }
                }
            }
        }
    }
}

#Preview {
    ZStack {
        Asset.homeBg.swiftUIImage
            .resizable()
            .scaledToFit()
        
        NavigationTitleView()
    }
}
