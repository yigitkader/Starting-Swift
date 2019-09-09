//
//  SignVC.swift
//  ParseInstaClone
//
//  Created by calzom on 9.09.2019.
//  Copyright © 2019 YigitKader. All rights reserved.
//

import UIKit

class SignVC: UIViewController {

    
    @IBOutlet weak var signNickLabel: UITextField!
    @IBOutlet weak var signPassLabel: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signInButton(_ sender: Any) {
        performSegue(withIdentifier: "toTabBar", sender: nil)
    }
    
    
    @IBAction func signUpButton(_ sender: Any) {
    }
    

}
