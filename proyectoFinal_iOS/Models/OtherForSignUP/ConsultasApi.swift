//
//  ConsultasApi.swift
//  proyectoFinal_iOS
//
//  Created by Cristian Bahamondes on 15-06-22.
//

import Foundation
import UIKit
import Alamofire

class ConsultasApi:ProtocolConsultasApi {
    
    //MARK: Singleton
    static var shared = ConsultasApi()

    func registerUser(name:String, email:String, password:String, complete:@escaping (_ code:Int, _ message:String) -> ()) {
        
        let pURL:String = "https://ongapi.alkemy.org/api/register"
        
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
            
        let parameters: [String: String] = [
            "name" : name,
            "email" : email,
            "password" : password,
        ]
        
        AF.request(pURL, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).response {response in
            
            if response.error != nil {
                complete(1,"se encontro un error")
                return
            }
            
            guard let data = response.data else {
                complete(2,"sin datos")
                return
            }
            
            do {
                let registryResponse = try JSONDecoder().decode(RegistryResponse.self, from:data)
                print("success: \(registryResponse.success ?? false)")
                print("message: \(registryResponse.message)")
                
                if (registryResponse.success ?? false) {
                    complete(0,registryResponse.message)
                }
                else
                {
                    complete(-1,registryResponse.message)
                }
            }
            catch let error {
                complete(3,"error al leer contenido \(error)")
            }
        }
    }
    
    func getNews() {
        
        let requestAUX = "https://ongapi.alkemy.org/api/news"
        
        AF.request(requestAUX).response { respuesta in
            //debugPrint(respuesta)
            
            guard let data = respuesta.data else {
                print("no hay data")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(NewsResponse.self, from: data)
                
                NewsResponse.shared.success = result.success
                NewsResponse.shared.data = result.data
                NewsResponse.shared.message = result.message
                
            }
            catch let error {
                print("Se produjo un error: \(error)")
            }
        }
    }
}
