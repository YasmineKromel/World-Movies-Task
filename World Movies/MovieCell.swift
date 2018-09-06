//
//  MovieCell.swift
//  World Movies
//
//  Created by mino on 7/1/18.
//  Copyright © 2018 mino. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {    
    
    // Mark : IBOutlets


 
    @IBOutlet weak var Mposter: UIImageView!
    
    @IBOutlet weak var Mtitle: UILabel!
    
    
    @IBOutlet weak var Moverview: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
