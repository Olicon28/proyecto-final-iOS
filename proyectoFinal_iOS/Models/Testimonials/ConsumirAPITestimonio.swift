//
//  ConsumirAPITestimonio.swift
//  proyectoFinal_iOS
//
//  Created by training on 23-06-22.
//

import Foundation
import Alamofire

class ConsumirAPITestimonio: ProtocolConsumirApiTestimonio
{
    
    static var shared = ConsumirAPITestimonio()
    func getTestimonio(){
    let requestAux = "https://ongapi.alkemy.org/api/testimonials"
        AF.request(requestAux).response {respuesta in
            guard let Data = respuesta.data else {print("No hay datos")
                return
            
                
                
                
            }
            
            do { let result = try JSONDecoder().decode(ResponseTestimonials.self, from: Data)
                
                ResponseTestimonials.shared.success=result.success
                ResponseTestimonials.shared.data=result.data
                ResponseTestimonials.shared.message=result.message
                
                
                
                
            }
            
            catch let error {
                print("error \(error)")
            }
            
        }
        
        
    }

    
    
    
}
