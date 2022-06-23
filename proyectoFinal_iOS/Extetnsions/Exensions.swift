//
//  Helper.swift
//  proyectoFinal_iOS
//
//  Created by alvaro.concha on 22-06-22.
//

import Foundation
import UIKit




extension String{

        init?(htmlEncodedString: String) {

            guard let data = htmlEncodedString.data(using: .utf8) else {
                return nil
            }

            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ]

            guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
                return nil
            }

            self.init(attributedString.string)

        }

    
}

