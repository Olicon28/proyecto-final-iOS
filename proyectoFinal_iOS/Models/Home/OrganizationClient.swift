//
//  OrganizationClient.swift
//  proyectoFinal_iOS
//
//  Created by training on 23-06-22.
//

import Foundation
import Alamofire

class OrganizationClient: ProtocolOrganization {
    static var shared = OrganizationClient()
    func getOrganization(){
    let requestPath = "https://ongapi.alkemy.org/api/organization"
        AF.request(requestPath).response {respuesta in
            guard let Data = respuesta.data else {print("No hay datos")
                return
                
            }
            
            do { let result = try JSONDecoder().decode(OrganizationResponse.self, from: Data)
                
                OrganizationResponse.shared.success=result.success
                OrganizationResponse.shared.data=result.data
                OrganizationResponse.shared.message=result.message
                
            }
            catch let error {
                print("error \(error)")
            }
            
        }
        
    }

}
