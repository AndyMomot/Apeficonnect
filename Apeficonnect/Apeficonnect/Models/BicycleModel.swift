//
//  BicycleModel.swift
//  Millvelorotour
//
//  Created by Andrii Momot on 25.10.2024.
//

import Foundation

struct BicycleModel: Identifiable, Codable {
    private(set) var id = UUID().uuidString
    private(set) var dateCreated = Date()
    var type: String
    var price: Int
    var condition: String
    var tags: [TagModel]
    
}
