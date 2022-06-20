//
//  UserResponse.swift
//  proyectoFinal_iOS
//
//  Created by alvaro.concha on 17-06-22.
//

import Foundation

struct UserResponse : Codable{
    let id : Int
    let name : String
    let email_verified_at : String?
    let password : String
    let role_id : Int
    let remember_token : String?
    let created_at : String
    let updated_at : String
    let deleted_at : String?
    let group_id : String?
    let latitude : String?
    let longitude : String?
    let address : String?
    let profile_image : String?
}

