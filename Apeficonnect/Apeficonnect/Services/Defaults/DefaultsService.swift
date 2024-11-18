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
    }
}
