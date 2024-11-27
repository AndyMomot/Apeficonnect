//
//  GoalCell.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 19.11.2024.
//

import SwiftUI

struct GoalCell: View {
    var position: Int
    var goal: GoalModel
    
    var body: some View {
        BlurredContainerView {
            VStack(spacing: 10) {
                Text("Bramka \(position)")
                    .foregroundStyle(.white)
                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 20))
                    .multilineTextAlignment(.center)
                
                HStack {
                    Spacer()
                    Text(goal.name)
                        .foregroundStyle(.dimGray)
                        .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 14))
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding(14)
                .background(.white)
                .cornerRadius(30, corners: .allCorners)
                
                HStack {
                    Spacer()
                    HStack {
                        Text("Do zadań")
                        Image(systemName: "arrow.right")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                    }
                    .foregroundStyle(.dimGray)
                    .font(Fonts.SFProDisplay.lightItalic.swiftUIFont(size: 12))
                    .padding(.vertical, 8)
                }
            }
        }
    }
}

#Preview {
    GoalCell(position: 1,
             goal: .init(
        name: "Goal 1",
        tasks: [
            .init(name: "Task 1", isCompleted: true),
            .init(name: "Task 2", isCompleted: false),
            .init(name: "Task 3", isCompleted: false),
        ]))
}
