//
//  GoalsViewModel.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 19.11.2024.
//

import Foundation

extension GoalsView {
    final class ViewModel: ObservableObject {
        @Published var showAddGoal = false
        @Published var showGoalDetails = false
        
        @Published var goals: [GoalModel] = []
        var goalToShow: GoalModel?
        
        func getGoals() {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                let goals = DefaultsService.shared.goals
                DispatchQueue.main.async { [self] in
                    self.goals = goals
                }
            }
        }
        
        func handleGoalDetails(action: GoalDetailsCell.ViewAction) {
            switch action {
            case .cancel:
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.showGoalDetails = false
                }
            case .toggleTask(let goalId, let taskId):
                DispatchQueue.global().async { [weak self] in
                    guard let self else { return }
                    
                    if let goalIndex = DefaultsService.shared.goals.firstIndex(where: {
                        $0.id == goalId
                    }) {
                        if let taskIndex = DefaultsService.shared.goals[goalIndex].tasks.firstIndex(where: {
                            $0.id == taskId
                        }) {
                            DefaultsService.shared.goals[goalIndex].tasks[taskIndex].isCompleted.toggle()
                            self.getGoals()
                        }
                    }
                    
                }
            case .finishGoal(let goalId):
                DispatchQueue.global().async { [weak self] in
                    guard let self else { return }
                    DefaultsService.shared.goals.removeAll(where: { $0.id == goalId})
                    self.getGoals()
                    
                    DispatchQueue.main.async { [self] in
                        self.showGoalDetails = false
                    }
                }
            }
        }
    }
}
