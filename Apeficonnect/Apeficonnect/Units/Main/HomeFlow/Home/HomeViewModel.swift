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
        @Published var showAddNote = false
        
        @Published var selectedSortItem = Sort.newFirst.rawValue
        @Published var selectedCategory = ""
        
        @Published var sortList: [String] = Sort.allCases.map { $0.rawValue }.sorted()
        @Published var categoryList: [String] = []
        @Published var notes: [NoteModel] = []
        
        // MARK: Functions
        func getCategories() {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                var items = DefaultsService.shared.noteCategories
                items.insert("Wszystko", at: 0)
                
                DispatchQueue.main.async { [self] in
                    self.selectedCategory = items.first ?? ""
                    self.categoryList = items
                }
            }
        }
        
        func getNotes() {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                var items = DefaultsService.shared.notes
                
                if !self.selectedCategory.isEmpty && self.selectedCategory != "Wszystko" {
                    items = items.filter { $0.category == self.selectedCategory }
                }
                
                switch (Sort(rawValue: self.selectedSortItem) ?? .newFirst) {
                case .az:
                    items = items.sorted(by: { $0.title < $1.title })
                case .za:
                    items = items.sorted(by: { $0.title > $1.title })
                case .newFirst:
                    items = items.sorted(by: { $0.date > $1.date })
                case .oldFirst:
                    items = items.sorted(by: { $0.date < $1.date })
                }
                
                DispatchQueue.main.async { [self] in
                    self.notes = items
                }
            }
        }
    }
}

extension HomeView {
    enum Sort: String, CaseIterable {
        case az = "A-Ż"
        case za = "Ż-A"
        case newFirst = "Najpierw now"
        case oldFirst = "Najpierw stare"
    }
}
