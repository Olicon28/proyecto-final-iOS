//
//  LoginResponse.swift
//  proyectoFinal_iOS
//
//  Created by alvaro.concha on 16-06-22.
//

import Foundation

struct LoginResponse : Codable {
    let success : Bool?
    let data : DataUserResponse?
    let message : String?
}
