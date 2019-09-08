//
//  FeedCell.swift
//  FirebaseInstaClone
//
//  Created by calzom on 8.09.2019.
//  Copyright © 2019 YigitKader. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    
    
    @IBOutlet weak var useremailLabel: UILabel!
    @IBOutlet weak var imageviewCell: UIImageView!
    @IBOutlet weak var usercommentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
