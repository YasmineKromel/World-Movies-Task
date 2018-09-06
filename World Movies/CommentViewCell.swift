//
//  CommentViewCell.swift
//  World Movies
//
//  Created by mino on 7/3/18.
//  Copyright © 2018 mino. All rights reserved.
//

import UIKit

class CommentViewCell: UITableViewCell {
    
    

    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var commentLbl: UILabel!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
