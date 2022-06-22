//
//  RegistryResponse.swift
//  proyectoFinal_iOS
//
//  Created by Cristian Bahamondes on 17-06-22.
//

import Foundation

struct RegistryResponse: Codable {
    
    let success: Bool?
    let data: DataClassResponse?
    let message: String
    let errors: ErrorsResponse?
    
}
