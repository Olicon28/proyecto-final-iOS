//
//  UserResponse.swift
//  proyectoFinal_iOS
//
//  Created by Cristian Bahamondes on 17-06-22.
//

import Foundation

struct UserResponse: Codable {
    
    let email, name, password: String
    let roleID: Int
    let updatedAt, createdAt: String
    let id: Int

    enum CodingKeys: String, CodingKey {
        case email, name, password
        case roleID = "role_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
    }
}
