//
//  DataClassResponse.swift
//  proyectoFinal_iOS
//
//  Created by Cristian Bahamondes on 17-06-22.
//

import Foundation

struct DataClassResponse: Codable {
    
    let user: UserResponse
    let token: String
    
}
