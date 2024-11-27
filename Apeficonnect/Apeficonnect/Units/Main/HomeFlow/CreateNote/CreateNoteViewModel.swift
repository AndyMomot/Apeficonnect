//
//  CreateNoteViewModel.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 27.11.2024.
//

import Foundation

extension CreateNoteView {
    final class ViewModel: ObservableObject {
        @Published var title = ""
        @Published var description = ""
        @Published var selectedCategory = ""
        @Published var categories: [String] = []
        @Published var showAddCategory = false
        @Published var newCategoryName = ""
        
        func getCategories() {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                let items = DefaultsService.shared.noteCategories
                DispatchQueue.main.async { [self] in
                    self.selectedCategory = items.first ?? ""
                    self.categories = items
                }
            }
        }
        
        func addCategory() {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                let shared = DefaultsService.shared
                if !shared.noteCategories.contains(where: { $0 == self.newCategoryName }) {
                    shared.noteCategories.append(self.newCategoryName)
                }
                self.getCategories()
            }
        }
        
        func saveNote(completion: @escaping () -> Void) {
            DispatchQueue.global().async { [weak self] in
                guard let self,
                      !self.title.isEmpty,
                      !self.description.isEmpty,
                      !self.selectedCategory.isEmpty
                else { return }
                
                let model = NoteModel(
                    title: self.title,
                    text: self.description,
                    category: self.selectedCategory
                )
                DefaultsService.shared.notes.append(model)
                
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
}
