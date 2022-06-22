//
//  ContactResponse.swift
//  proyectoFinal_iOS
//
//  Created by training on 22-06-22.
//

import Foundation

struct ContactResponse:Decodable {
    var success:Bool
    var data:DataContact
    var message:String
    
    init (succes: Bool, data:DataContact, message:String){
        self.success=succes
        self.data=data
        self.message=message
    }
}

