//
//  FAQModel.swift
//  Libarorent
//
//  Created by Andrii Momot on 09.10.2024.
//

import Foundation

struct FAQModel: Identifiable {
    private(set) var id = UUID().uuidString
    var title: String
    var text: String
}
