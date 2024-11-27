//
//  NoteModel.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 27.11.2024.
//

import Foundation

struct NoteModel: Identifiable, Codable {
    private(set) var id = UUID().uuidString
    private(set) var date = Date()
    var title: String
    var text: String
    var category: String
}
