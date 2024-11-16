//
//  NavigationTitleView.swift
//  Millvelorotour
//
//  Created by Andrii Momot on 25.10.2024.
//

import SwiftUI

struct NavigationView<L: View, R: View>: View {
    var leftView: L
    var text: String
    var rightView: R
    
    init(text: String,
         @ViewBuilder leftView: () -> L = { EmptyView() },
         @ViewBuilder rightView: () -> R = { EmptyView() }) {
        self.text = text
        self.leftView = leftView()
        self.rightView = rightView()
    }
    
    var body: some View {
        HStack {
            if leftView is EmptyView {
                rightView
                    .hidden()
            } else {
                leftView
            }
            
            Spacer()
            Text(text)
                .foregroundStyle(.gray)
                .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 36))
                .lineLimit(2)
                .minimumScaleFactor(0.7)
                .multilineTextAlignment(.center)
            Spacer()
            
            if rightView is EmptyView {
                leftView
                    .hidden()
            } else {
                rightView
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    VStack {
        NavigationView(text: "Hello, world!") {
            Button {
                print("<- Back")
            } label: {
                NavigationButton(imageName: "arrowBack") { }
            }
        } rightView: {
            Button {
                print("Forward ->")
            } label: {
                NavigationButton(imageName: "plus") { }
            }
        }
        
        NavigationView(text: "Hello, world!", leftView: {
            Button {
                print("<- Back")
            } label: {
                NavigationButton(imageName: "arrowBack") { }
            }
        })
        
        NavigationView(text: "Hello, world!", rightView:  {
            Button {
                print("Forward ->")
            } label: {
                NavigationButton(imageName: "plus") { }
            }
        })
        
        NavigationView(text: "Hello, world!")
        
        Spacer()
    }
    .padding(.horizontal)
}
