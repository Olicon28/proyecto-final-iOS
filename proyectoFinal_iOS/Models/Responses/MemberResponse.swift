//
//  MemberResponse.swift
//  proyectoFinal_iOS
//
//  Created by alvaro.concha on 22-06-22.
//

import Foundation

struct MemberResponse : Codable {
    let id : Int
    let name : String
    let image : String?
    let description : String
    let facebookUrl : String
    let linkedinUrl : String
    let created_at : String
    let updated_at : String
    let deleted_at : String?
    let group_id : Int?    
}
