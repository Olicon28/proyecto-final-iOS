//
//  LoginAuthenticated.swift
//  proyectoFinal_iOS
//
//  Created by Cristian Bahamondes on 15-06-22.
//

import Foundation

class LoginAuthenticated:Decodable {
    //MARK: Properties
    var success:String
    var error:String
    
    //MARK: Init
    init(success:String, error:String) {
        self.success = success
        self.error = error
    }
}
