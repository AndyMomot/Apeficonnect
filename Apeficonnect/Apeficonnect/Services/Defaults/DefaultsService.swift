//
//  DefaultsService.swift
//
//  Created by Andrii Momot on 16.04.2024.
//

import Foundation

final class DefaultsService {
    static let shared = DefaultsService()
    private let standard = UserDefaults.standard
    private init() {}
}

extension DefaultsService {
    var flow: RootContentView.ViewState {
        get {
            let name = standard.string(forKey: Keys.flow.rawValue) ?? ""
            return RootContentView.ViewState(rawValue: name) ?? .onboarding
        }
        set {
            standard.set(newValue.rawValue, forKey: Keys.flow.rawValue)
        }
    }
    
    var user: UserModel? {
        get {
            guard let data = standard.object(forKey: Keys.user.rawValue) as? Data,
                  let user = try? JSONDecoder().decode(UserModel.self, from: data)
            else {
                return nil
            }
            
            return user
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                standard.setValue(data, forKey: Keys.user.rawValue)
            }
        }
    }
    
    var incomeCostItems: [IncomeCostModel] {
        get {
            guard let data = standard.object(forKey: Keys.incomeCostItems.rawValue) as? Data,
                  let items = try? JSONDecoder().decode([IncomeCostModel].self, from: data)
            else {
                return []
            }
            
            return items
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                standard.setValue(data, forKey: Keys.incomeCostItems.rawValue)
            }
        }
    }
    
    var incomeCostCategories: [IncomeCostCategoryModel] {
        get {
            guard let data = standard.object(forKey: Keys.incomeCostCategories.rawValue) as? Data,
                  let items = try? JSONDecoder().decode([IncomeCostCategoryModel].self, from: data)
            else {
                return []
            }
            
            return items
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                standard.setValue(data, forKey: Keys.incomeCostCategories.rawValue)
            }
        }
    }
    
    var goals: [GoalModel] {
        get {
            guard let data = standard.object(forKey: Keys.goals.rawValue) as? Data,
                  let items = try? JSONDecoder().decode([GoalModel].self, from: data)
            else {
                return []
            }
            
            return items
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                standard.setValue(data, forKey: Keys.goals.rawValue)
            }
        }
    }
    
    var notes: [NoteModel] {
        get {
            guard let data = standard.object(forKey: Keys.notes.rawValue) as? Data,
                  let items = try? JSONDecoder().decode([NoteModel].self, from: data)
            else {
                return []
            }
            
            return items
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                standard.setValue(data, forKey: Keys.notes.rawValue)
            }
        }
    }
    
    var noteCategories: [String] {
        get {
            guard let data = standard.object(forKey: Keys.noteCategories.rawValue) as? Data,
                  let items = try? JSONDecoder().decode([String].self, from: data)
            else {
                return []
            }
            
            return items
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                standard.setValue(data, forKey: Keys.noteCategories.rawValue)
            }
        }
    }
}

extension DefaultsService {
    func removeAll() {
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            standard.removePersistentDomain(forName: bundleIdentifier)
        }
    }
}

// MARK: - Keys
extension DefaultsService {
    enum Keys: String {
        case flow
        case user
        case incomeCostItems
        case incomeCostCategories
        case goals
        case notes
        case noteCategories
    }
}
