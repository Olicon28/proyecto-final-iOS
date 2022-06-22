//
//  DataContact.swift
//  proyectoFinal_iOS
//
//  Created by training on 22-06-22.
//

import Foundation

struct DataContact:Decodable{
    var name:String?
    var email: String?
    var phone: String?
    var message:String?
    var updated_at:String?
    var created_at:String?
    var id:Int?
}
