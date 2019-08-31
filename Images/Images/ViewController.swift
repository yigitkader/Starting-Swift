//
//  ViewController.swift
//  Images
//
//  Created by calzom on 24.08.2019.
//  Copyright © 2019 YigitKader. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    
    var num = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }

    @IBAction func changeButton(_ sender: Any) {
        
        
        
        if num % 2 == 0 {
            imageView.image = UIImage(named: "james.jpg")
            num += 1
        }
        else{
            imageView.image = UIImage(named: "kirk.jpg")
            num += 1
        }
    }
    

}

