//
//  StructNews.swift
//  proyectoFinal_iOS
//
//  Created by Cristian Bahamondes on 21-06-22.
//

import Foundation

struct StructNews:Decodable {
    
    //MARK: Atributos
    var id:Int
    var name:String
    var slug:String?
    var content:String
    var image:String?
    var user_id:Int?
    var category_id:Int?
    var created_at:String
    var updated_at:String
    var deleted_at:String?
    var group_id:Int?

}
