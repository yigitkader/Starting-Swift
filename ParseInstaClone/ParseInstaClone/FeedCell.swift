//
//  FeedCell.swift
//  ParseInstaClone
//
//  Created by calzom on 16.09.2019.
//  Copyright © 2019 YigitKader. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var uuidLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        uuidLabel.isHidden = true
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func likeButton(_ sender: Any) {
    }
    
    @IBAction func commentButton(_ sender: Any) {
    }
    
    

}
