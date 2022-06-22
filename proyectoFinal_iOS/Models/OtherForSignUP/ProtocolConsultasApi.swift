//
//  ProtocolConsultasApi.swift
//  proyectoFinal_iOS
//
//  Created by Cristian Bahamondes on 16-06-22.
//

import Foundation

protocol ProtocolConsultasApi {
    
    func registerUser(name:String, email:String, password:String, complete:@escaping (_ code:Int, _ message:String) -> ())
    
    func getNews ()
}
