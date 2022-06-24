//
//  Organization.swift
//  proyectoFinal_iOS
//
//  Created by training on 23-06-22.
//

import Foundation

struct Organization: Codable {

    let id: Int

    let name: String

    let logo: String?

    let short_description: String
    
    let long_description: String
    
    let welcome_text: String

    let created_at: String

    let updated_at: String

    let delated_at: String?

    let group_id: Int?
    
}
