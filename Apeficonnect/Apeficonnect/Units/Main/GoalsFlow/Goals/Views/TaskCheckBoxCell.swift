//
//  TaskCheckBoxCell.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 19.11.2024.
//

import SwiftUI

struct TaskCheckBoxCell: View {
    var task: GoalTask
    var onCheckBox: (String) -> Void
    
    @State var isCompleted = false
    
    var body: some View {
        HStack {
            Text(task.name)
                .foregroundStyle(Color.dimGray)
                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 12))
            
            Spacer()
            
            Button {
                onCheckBox(task.id)
                isCompleted.toggle()
            } label: {
                RoundedRectangle(cornerRadius: 2)
                    .scaledToFit()
                    .foregroundStyle(.white)
                    .frame(width: 18)
                    .padding(.vertical, 4)
                    .padding(.leading, 4)
                    .overlay {
                        if isCompleted {
                            Image(systemName: "checkmark")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color.blue,
                                            Color.purple,
                                            Color.pink,
                                            Color.orange]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .padding(4)
                        }
                    }
            }
        }
        .onAppear {
            withAnimation {
                isCompleted = task.isCompleted
            }
        }
    }
}

#Preview {
    ZStack {
        Color.purple.opacity(0.1)
        
        VStack {
            TaskCheckBoxCell(task: .init(name: "Task 1", isCompleted: true)) {_ in}
            TaskCheckBoxCell(task: .init(name: "Task 2", isCompleted: false)) {_ in}
        }
        .padding()
    }
}
