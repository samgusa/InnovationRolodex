//
//  MainTableViewCell.swift
//  InnovationRolodex
//
//  Created by Sam Greenhill on 7/29/18.
//  Copyright © 2018 simplyAmazingMachines. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    
    @IBOutlet weak var personImage: UIImageView!
    
    var imageType = ""
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var phoneLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
