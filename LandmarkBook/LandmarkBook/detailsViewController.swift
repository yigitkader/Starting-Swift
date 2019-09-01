//
//  detailsViewController.swift
//  LandmarkBook
//
//  Created by calzom on 1.09.2019.
//  Copyright © 2019 YigitKader. All rights reserved.
//

import UIKit

class detailsViewController: UIViewController {

    
    
    @IBOutlet weak var landmarkImageView: UIImageView!
    @IBOutlet weak var landmarkNameLabel: UILabel!
    
    var landmarkName = ""
    var landmarkImage = UIImage()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        landmarkImageView.image = landmarkImage
        landmarkNameLabel.text = landmarkName
        
        
    }
    
    
    
    

}
