//
//  LoginUser.swift
//  proyectoFinal_iOS
//
//  Created by Cristian Bahamondes on 15-06-22.
//

import Foundation
import Alamofire

class LoginUser:Decodable {
    //MARK: Properties
    var name:String
    var email:String
    var password:String
    //MARK: Init
    init(name:String, email:String, password:String) {
        self.name = name
        self.email = email
        self.password = password
    }
}
