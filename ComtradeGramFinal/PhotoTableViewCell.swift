//
//  PhotoTableViewCell.swift
//  ComtradeGramFinal
//
//  Created by Vladimir Gutic on 2/11/18.
//  Copyright © 2018 com.comtrade.Gram. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var imageTableCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
