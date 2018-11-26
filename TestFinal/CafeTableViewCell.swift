//
//  CafeTableViewCell.swift
//  TestFinal
//
//  Created by vPro on 25/11/2018.
//  Copyright © 2018 zineb. All rights reserved.
//

import UIKit

class CafeTableViewCell: UITableViewCell {
    
    @IBOutlet var labelNom: UILabel!
    @IBOutlet var labelType: UILabel!
    @IBOutlet var labelLocation: UILabel!
    @IBOutlet var imageViewPhoto: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
