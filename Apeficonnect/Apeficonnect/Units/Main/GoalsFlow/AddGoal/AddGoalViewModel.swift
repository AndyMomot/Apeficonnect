//
//  AddGoalViewModel.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 19.11.2024.
//

import Foundation

extension AddGoalView {
    final class ViewModel: ObservableObject {
        @Published var goalName = ""
        @Published var taskName = ""
        @Published var tasks: [String] = []
        
        func removeTask(name: String) {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.tasks.removeAll(where: { $0 == name })
            }
        }
        
        func addTask() {
            DispatchQueue.main.async { [weak self] in
                guard let self, !self.taskName.isEmpty else { return }
                if !self.tasks.contains(where: { $0 == self.taskName }) {
                    self.tasks.append(self.taskName)
                    self.taskName = ""
                }
            }
        }
        
        func addGoal(completion: @escaping () -> Void) {
            DispatchQueue.global().async { [weak self] in
                guard let self,
                      !self.goalName.isEmpty,
                      !self.tasks.isEmpty
                else { return }
                
                let tasks = self.tasks.map { GoalTask(name: $0) }
                let model = GoalModel(name: self.goalName, tasks: tasks)
                DefaultsService.shared.goals.append(model)
                
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
}
