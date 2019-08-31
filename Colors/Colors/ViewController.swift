//
//  ViewController.swift
//  Colors
//
//  Created by calzom on 31.08.2019.
//  Copyright © 2019 YigitKader. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func changeColorButton(_ sender: Any) {
        
        if counter % 2 == 0 {
            view.backgroundColor = UIColor.black
            counter += 1
        }
        else{
            view.backgroundColor = UIColor.white
            counter += 1
        }
        
    }
    
}

