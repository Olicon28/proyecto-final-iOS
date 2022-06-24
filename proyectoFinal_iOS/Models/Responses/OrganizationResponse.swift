//
//  OrganizationResponse.swift
//  proyectoFinal_iOS
//
//  Created by training on 23-06-22.
//

import Foundation

struct OrganizationResponse: Codable {
    
    let success :Bool
    let data : Organization?
    let message :String
    
}
