//
//  UserModel.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 17.11.2024.
//

import Foundation

struct UserModel: Codable {
    private(set) var id = UUID().uuidString
    var nickName: String
}
