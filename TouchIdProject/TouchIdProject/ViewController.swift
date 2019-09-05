//
//  ViewController.swift
//  TouchIdProject
//
//  Created by calzom on 5.09.2019.
//  Copyright © 2019 YigitKader. All rights reserved.
//

import UIKit
import LocalAuthentication  // add this library



class ViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        touchIdCheck()
        
        
    }


    //TOUCH ID CONTROL FUNC
    func touchIdCheck() {
        
        let authContext = LAContext()
        var error : NSError?
        if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            
        }
        
        authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Control") { (success, error) in
            
            if success == true {
                self.statusLabel.text =  "Successful"
            }
            else {
                self.statusLabel.text = "Fail"
            }
        }
    }
    
    
    
    
    
    
    
    
}

