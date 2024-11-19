//
//  HomeViewModel.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 18.11.2024.
//

import Foundation

extension HomeView {
    final class ViewModel: ObservableObject {
        
        // MARK: Published properties
        @Published var showProfile = false
        
        @Published var selectedYear = ""
        @Published var selectedMonth = ""
        @Published var isSetInitPikerValues = false
        
        @Published var incomeItems: [Int] = []
        @Published var costItems: [Int] = []
        @Published var incomeCostItems:  [IncomeCostModel] = []
        
        // MARK: Computed properties
        var yearsList: [String] {
            let currentYear = Calendar.current.component(.year, from: Date())
            return (0..<5).map { "\(currentYear - $0)" }
        }
        
        var monthList: [String] {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale.current // Use the current locale for localization
            dateFormatter.dateFormat = "MMMM" // Full month name (e.g., January, February)

            // Generate a list of 12 months
            let months = (1...12).map { monthNumber -> String in
                var dateComponents = DateComponents()
                dateComponents.month = monthNumber
                let calendar = Calendar.current
                let date = calendar.date(from: dateComponents)!
                return dateFormatter.string(from: date)
            }
            
            return months
        }
        
        // MARK: Functions
        func getCurrentYear() -> String {
            "\(Calendar.current.component(.year, from: Date()))"
        }
        
        func getCurrentMonth() -> String {
            // Create a DateFormatter
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM" // Set format to full month name (e.g., January, February)

            // Get the current date
            let currentDate = Date()

            // Format the current date to get the current month
            let currentMonth = dateFormatter.string(from: currentDate)
            return currentMonth
        }
        
        func setInitialPickerValue() {
            DispatchQueue.main.async { [weak self] in
                guard let self, !self.isSetInitPikerValues else { return }
                self.selectedYear = self.getCurrentYear()
                self.selectedMonth = self.getCurrentMonth()
                self.isSetInitPikerValues = true
                self.getItems()
            }
        }
        
        func getItems() {
            DispatchQueue.global().async { [weak self] in
                guard let self, let selectedDate = self.getSelectedDate() else { return }
                
                let calendar = Calendar.current
                let filterYear = calendar.component(.year, from: selectedDate)
                let filterMonth = calendar.component(.month, from: selectedDate)
                
                let items = DefaultsService.shared.incomeCostItems.filter {
                    let modelYear = calendar.component(.year, from: $0.date)
                    let modelMonth = calendar.component(.month, from: $0.date)
                    return modelYear == filterYear && modelMonth == filterMonth
                }
                let incomeItems = items.filter { $0.type == .income }.map { $0.amount }
                let costItems = items.filter { $0.type == .cost }.map { $0.amount }
                
                DispatchQueue.main.async { [self] in
                    self.incomeItems = incomeItems
                    self.costItems = costItems
                    self.incomeCostItems = items
                }
            }
        }
        
        func getSelectedDate() -> Date? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM"
            if let monthIndex = monthList.firstIndex(where: {$0 == selectedMonth} ) {
                
                let monthNumber = monthIndex + 1
                var dateComponents = DateComponents()
                dateComponents.year = Int(selectedYear)
                dateComponents.month = monthNumber

                let calendar = Calendar.current
                let date = calendar.date(from: dateComponents)
                return date
            } else {
                return nil
            }
        }
    }
}
