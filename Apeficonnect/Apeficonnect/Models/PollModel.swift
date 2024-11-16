//
//  PollModel.swift
//  Millvelorotour
//
//  Created by Andrii Momot on 01.11.2024.
//

import Foundation

struct PollModel: Identifiable {
    private(set) var id = UUID().uuidString
    var name: String
    var answers: [PollAnswer]
    
    var finalAnswer: String?
}

struct PollAnswer {
    private(set) var id = UUID().uuidString
    var name: String
}
