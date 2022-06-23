//
//  ProtocolResponseTestimonials.swift
//  proyectoFinal_iOS
//
//  Created by training on 23-06-22.
//

import Foundation

protocol ProtocolResponseTestimonials {
    
    var success: Bool {
        get set
    }
    var data: [DataTestimonio] {
        
        get set
    }
    
    var message: String {
        get set
    }
    
    
}
