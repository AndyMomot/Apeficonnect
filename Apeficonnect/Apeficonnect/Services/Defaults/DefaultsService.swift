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
    
    var bicycles: [BicycleModel] {
        get {
            guard let data = standard.object(forKey: Keys.bicycles.rawValue) as? Data else {
                return []
            }
            let items = try? JSONDecoder().decode([BicycleModel].self, from: data)
            return items ?? []
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                standard.setValue(data, forKey: Keys.bicycles.rawValue)
            }
        }
    }
    
    var calculateRentResults: [CalculateRentResultModel] {
        get {
            guard let data = standard.object(forKey: Keys.calculateRentResults.rawValue) as? Data else {
                return []
            }
            let items = try? JSONDecoder().decode([CalculateRentResultModel].self, from: data)
            return items ?? []
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                standard.setValue(data, forKey: Keys.calculateRentResults.rawValue)
            }
        }
    }
    
    var compleatedPolls: Bool {
        get {
            standard.bool(forKey: Keys.compleatedPolls.rawValue)
        }
        set {
            standard.set(newValue, forKey: Keys.compleatedPolls.rawValue)
        }
    }
    
    var isBikeReturnReminder: Bool {
        get {
            standard.bool(forKey: Keys.isBikeReturnReminder.rawValue)
        }
        set {
            standard.set(newValue, forKey: Keys.isBikeReturnReminder.rawValue)
        }
    }
    
    var isNotificationSounds: Bool {
        get {
            standard.bool(forKey: Keys.isNotificationSounds.rawValue)
        }
        set {
            standard.set(newValue, forKey: Keys.isNotificationSounds.rawValue)
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
        case bicycles
        case calculateRentResults
        case compleatedPolls
        
        case isBikeReturnReminder
        case isNotificationSounds
    }
}
