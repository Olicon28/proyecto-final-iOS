//
//  TestimonioTableViewCell.swift
//  proyectoFinal_iOS
//
//  Created by training on 22-06-22.
//

import UIKit

class TestimonioTableViewCell: UITableViewCell {

    @IBOutlet weak var ContactoNombre: UILabel!
    @IBOutlet weak var DescripcionContacto: UITextView!
    @IBOutlet weak var ImagenContacto: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
