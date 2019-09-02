//
//  DetailsViewController.swift
//  SimpsonBook
//
//  Created by calzom on 2.09.2019.
//  Copyright © 2019 YigitKader. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    
   var selectedSimpson = Simpson()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = selectedSimpson.image
        nameLabel.text = selectedSimpson.name
        bioLabel.text = selectedSimpson.bio
        
        
    }
    

   
  

}
