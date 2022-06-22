//
//  NewsResponse.swift
//  proyectoFinal_iOS
//
//  Created by Cristian Bahamondes on 21-06-22.
//

import Foundation

struct NewsResponse: Decodable, ProtocolNewsResponse {
    
    //MARK: Singleton
    static var shared = NewsResponse()
    
    var success:Bool
    var data:[StructNews]
    var message:String
    
    init(success:Bool = false, data:[StructNews] = [], message:String = String()) {
        self.success = success
        self.data = data
        self.message = message
    }
    
}
