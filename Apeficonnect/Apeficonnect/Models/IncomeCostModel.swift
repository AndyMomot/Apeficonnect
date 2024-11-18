//
//  IncomeCostModel.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 18.11.2024.
//

import Foundation

struct IncomeCostModel: Codable, Identifiable {
    private(set) var id = UUID().uuidString
    var category: IncomeCostCategoryModel
    var type: IncomeCostType
    var amount: Int
}

struct IncomeCostCategoryModel: Codable, Identifiable {
    private(set) var id = UUID().uuidString
    var name: String
}

enum IncomeCostType: String, Codable, CaseIterable {
    case income = "Income"
    case cost = "Cost"
}
