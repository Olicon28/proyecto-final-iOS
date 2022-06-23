//
//  ResponseTestimonials.swift
//  proyectoFinal_iOS
//
//  Created by training on 23-06-22.
//

import Foundation

struct ResponseTestimonials:Decodable,ProtocolResponseTestimonials
{
    static var shared = ResponseTestimonials()
    
    var success :Bool
    var data :[DataTestimonio]
    var message :String
    
    init(success:Bool=false,data:[DataTestimonio]=[],message:String=String())
    
    {
        self.success=success
        self.data=data
        self.message=message
        
        
    }
    
    
    
    
}
