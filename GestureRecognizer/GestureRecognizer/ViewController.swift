//
//  ViewController.swift
//  GestureRecognizer
//
//  Created by calzom on 25.08.2019.
//  Copyright © 2019 YigitKader. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var num = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
     
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.changePic))
        
        imageView.addGestureRecognizer(gestureRecognizer)
        
    }

    
    @objc func changePic(){
        
        if num % 2 == 0 {
            
           imageView.image = UIImage(named: "james.jpg")
            nameLabel.text = "James Hetfield"
            num += 1
           
        }
        else{
            imageView.image = UIImage(named: "kirk.jpg")
            nameLabel.text = "Kirk Hammet"
            num += 1
        }
        
    }

}

