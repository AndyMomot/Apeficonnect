//
//  FinanceTrackerViewModel.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 18.11.2024.
//

import Foundation

extension FinanceTrackerView {
    final class ViewModel: ObservableObject {
        @Published var incomeItems: [Int] = []
        @Published var costItems: [Int] = []
        
        @Published var income = 0
        @Published var cost = 0
        
        @Published var showAddItem = false
        @Published var categories: [IncomeCostCategoryModel] = []
        @Published var showAddCategory = false
        @Published var amount = ""
        
        var selectedCategory: IncomeCostCategoryModel?
        var selectedType: IncomeCostType?
        
        func getItems() {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                let categories = DefaultsService.shared.incomeCostItems
                
                let incomeItems = categories.filter { $0.type == .income }.map { $0.amount }
                let costItems = categories.filter { $0.type == .cost }.map { $0.amount }
                
                let income = incomeItems.reduce(0) {$0 + $1}
                let cost = costItems.reduce(0) {$0 + $1}
                
                DispatchQueue.main.async { [self] in
                    self.incomeItems = incomeItems
                    self.costItems = costItems
                    self.income = income
                    self.cost = cost
                }
            }
        }
        
        func getCategories() {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                let categories = DefaultsService.shared.incomeCostCategories
                DispatchQueue.main.async { [self] in
                    self.categories = categories
                }
            }
        }
        
        func handleCategoryList(action: IncomeCategoryList.ViewAction) {
            switch action {
            case .onSelect(let item):
                selectedCategory = item
            case .onAddNew:
                showAddCategory.toggle()
            }
        }
        
        func saveItem() {
            DispatchQueue.global().async { [weak self] in
                guard let self,
                      let selectedCategory,
                      let selectedType,
                      let amount = Int(self.amount)
                else {
                    return
                }
                
                let model = IncomeCostModel(
                    category: selectedCategory,
                    type: selectedType,
                    amount: amount)
                
                DefaultsService.shared.incomeCostItems.append(model)
                self.getItems()
                
                DispatchQueue.main.async { [self] in
                    self.selectedCategory = nil
                    self.selectedType = nil
                    self.amount = ""
                    self.showAddItem = false
                }
            }
        }
    }
}
