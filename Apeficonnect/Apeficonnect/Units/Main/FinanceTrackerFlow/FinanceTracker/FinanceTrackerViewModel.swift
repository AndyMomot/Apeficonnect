//
//  FinanceTrackerViewModel.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 18.11.2024.
//

import Foundation

extension FinanceTrackerView {
    final class ViewModel: ObservableObject {
        @Published var incomeItems: [Int] = [1, 4, 2, 45, 2, 4, 2, 5, 2]
        @Published var costItems: [Int] = [2, 4, 2, 4, 2, 4, 21, 34]
        
        @Published var income = 0
        @Published var cost = 0
    }
}
