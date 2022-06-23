//
//  MembersResponse.swift
//  proyectoFinal_iOS
//
//  Created by alvaro.concha on 22-06-22.
//

import Foundation

struct StaffResponse : Codable{
    let success : Bool?
    let data : Array<MemberResponse>?
    let message : String
}
