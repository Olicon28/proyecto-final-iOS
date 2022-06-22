//
//  ProtocolNewsResponse.swift
//  proyectoFinal_iOS
//
//  Created by Cristian Bahamondes on 22-06-22.
//

import Foundation

protocol ProtocolNewsResponse {
    
    var success:Bool {get set}
    var data:[StructNews] {get set}
    var message:String {get set}

    
}
