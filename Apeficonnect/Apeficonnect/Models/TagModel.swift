//
//  TagModel.swift
//  Millvelorotour
//
//  Created by Andrii Momot on 26.10.2024.
//

import Foundation

struct TagModel: Identifiable, Codable, Hashable {
    private(set) var id = UUID().uuidString
    var title: String
}
