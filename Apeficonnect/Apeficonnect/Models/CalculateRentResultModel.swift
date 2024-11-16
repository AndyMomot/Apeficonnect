//
//  CalculateRentResultModel.swift
//  Millvelorotour
//
//  Created by Andrii Momot on 01.11.2024.
//

import Foundation

struct CalculateRentResultModel: Identifiable, Codable {
    private(set) var id = UUID().uuidString
    var type: String
    var date: Date
    var lengthOfLease, amount: Int
    
    var timeReturn: String {
        let dateReturn = date.addOrSubtract(component: .hour, value: lengthOfLease)
        return dateReturn.toString(format: .HHMM)
    }
}
