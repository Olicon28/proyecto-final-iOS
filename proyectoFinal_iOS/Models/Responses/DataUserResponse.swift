//
//  DataUserResponse.swift
//  proyectoFinal_iOS
//
//  Created by alvaro.concha on 17-06-22.
//

import Foundation

struct DataUserResponse : Codable{
    let user: UserResponse
    let token: String
}
