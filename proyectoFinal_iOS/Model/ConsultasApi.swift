//
//  ConsultasApi.swift
//  proyectoFinal_iOS
//
//  Created by Cristian Bahamondes on 15-06-22.
//

import Foundation
import Alamofire

class ConsultasApi {

    func getAuthMe() {
        
        AF.request("https://ongapi.alkemy.org/api/auth/me").response {respuesta in
                    debugPrint(respuesta)
            guard let data = respuesta.data else {
                        print("no hay data")
                        return
                
            }
            do {
                let result = try JSONDecoder().decode([LoginAuthenticated].self, from: data)
                        //print(result)
                result.forEach { LoUser in
                    print(LoUser.success)
                    print(LoUser.error)
                }
            }
            catch let error {
                print("Se produjo un error: \(error)")
                
            }
        }
    }
}
