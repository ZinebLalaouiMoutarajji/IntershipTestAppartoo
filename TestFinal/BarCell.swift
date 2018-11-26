//
//  BarCell.swift
//  TestFinal
//
//  Created by vPro on 26/11/2018.
//  Copyright © 2018 zineb. All rights reserved.
//

import UIKit

class BarCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
   
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var desc: UILabel!
    
    
    @IBOutlet weak var author: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
