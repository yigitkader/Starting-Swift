//
//  FeedCell.swift
//  ParseInstaClone
//
//  Created by calzom on 16.09.2019.
//  Copyright © 2019 YigitKader. All rights reserved.
//

import UIKit
import Parse

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
        
        let likeObject = PFObject(className: "Likes")
        likeObject["from"] = PFUser.current()?.username
        likeObject["to"] = uuidLabel.text
        
        likeObject.saveInBackground { (success, error) in
            
            if error != nil {
                
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                
                let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                
                alert.addAction(okButton)
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                
            }
            else{
                print("like saved")
            }
        }
        
    }
    
    @IBAction func commentButton(_ sender: Any) {
        
        
        let commentObject = PFObject(className: "Comments")
        commentObject["from"] = PFUser.current()?.username
        commentObject["to"] = uuidLabel.text
        
        commentObject.saveInBackground { (success, error) in
            
            if error != nil {
                
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                
                let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                
                alert.addAction(okButton)
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                
            }
            else{
                print("comment saved")
            }
        }

        
    }
    
    

}
