//
//  SecondViewController.swift
//  Segues
//
//  Created by calzom on 9.08.2019.
//  Copyright © 2019 YigitKader. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

      nameLabel.text = "Name is \(name)"
        
    }
    
    
    //GO BACK TO FIRST PAGE
    @IBAction func goBackButton(_ sender: Any) {
        
        // Dismiss the second page
        self.dismiss(animated: true, completion: nil)
    }
    
}
