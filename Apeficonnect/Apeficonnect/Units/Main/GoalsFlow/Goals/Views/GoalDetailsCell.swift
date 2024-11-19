//
//  GoalDetailsCell.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 19.11.2024.
//

import SwiftUI

struct GoalDetailsCell: View {
    @State var goal: GoalModel
    var action: (ViewAction) -> Void
    
    @State private var progress = 0.0
    
    var body: some View {
        BlurredContainerView {
            VStack(spacing: 20) {
                HStack {
                    Button {
                        action(.cancel)
                    } label: {
                        HStack {
                            Image(systemName: "arrow.left")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                            Text("Back")
                        }
                        .foregroundStyle(.dimGray)
                        .font(Fonts.SFProDisplay.lightItalic.swiftUIFont(size: 12))
                        .padding(.vertical, 8)
                    }
                    Spacer()
                }
                
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
                
                Text("The goal was achieved by \(Int(progress * 100))%")
                    .foregroundStyle(.dimGray)
                    .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 12))
                    .multilineTextAlignment(.center)
                
                ZStack {
                    ProgressView(value: progress)
                        .tint(.red)
                    
                    HStack {
                        Spacer()
                        Circle()
                            .stroke(LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.blue,
                                    Color.purple,
                                    Color.pink,
                                    Color.orange]),
                                startPoint: .leading,
                                endPoint: .trailing
                            ), lineWidth: 1)
                            .frame(height: 56)
                            .overlay {
                                Asset.cup.swiftUIImage
                                    .resizable()
                                    .scaledToFit()
                                    .padding(10)
                            }
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Tasks:")
                    ForEach(goal.tasks) { task in
                        TaskCheckBoxCell(task: task) { id in
                            toggleTask(id: id)
                            action(.toggleTask(
                                goalId: goal.id,
                                taskId: id))
                        }
                    }
                }
                
                NextButton(title: "Goal achieved") {
                    action(.finishGoal(goalId: goal.id))
                }
                .frame(height: 59)
                .padding(.vertical)
            }
        }
        .onAppear {
            DispatchQueue.main.async {
                withAnimation {
                    progress = goal.progress
                }
            }
        }
    }
}

extension GoalDetailsCell {
    func toggleTask(id: String) {
        DispatchQueue.main.async {
            if let index = goal.tasks.firstIndex(where: {$0.id == id}) {
                withAnimation {
                    goal.tasks[index].isCompleted.toggle()
                    progress = goal.progress
                }
            }
        }
    }
}


extension GoalDetailsCell {
    enum ViewAction {
        case cancel
        case toggleTask(goalId: String, taskId: String)
        case finishGoal(goalId: String)
    }
}

#Preview {
    GoalDetailsCell(goal: .init(
        name: "Goal 1",
        tasks: [
            .init(name: "Task 1", isCompleted: true),
            .init(name: "Task 2", isCompleted: false),
            .init(name: "Task 3", isCompleted: false),
        ])
    ) { _ in }
    .padding()
}
