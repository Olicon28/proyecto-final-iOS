//
//  DataTestimonio.swift
//  proyectoFinal_iOS
//
//  Created by training on 23-06-22.
//

import Foundation

struct DataTestimonio: Decodable {

    

    var id: Int

    var name: String

    var image: String

    var description: String

    var created_at: String

    var updated_at: String

    var delated_at: String?

    var group_id: Int?

}
