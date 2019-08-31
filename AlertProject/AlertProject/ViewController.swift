//
//  ViewController.swift
//  AlertProject
//
//  Created by calzom on 22.08.2019.
//  Copyright © 2019 YigitKader. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var passField2: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func alertButton(_ sender: Any) {
        
        //call the alert function
        alertFunc()
        
        
    }
    
    @IBAction func submitButton(_ sender: Any) {
        
        if nameField.text == "" || passField.text == "" || passField2.text == ""  {
            
            warningAlert()
        }
        else {
            
            if passField.text != passField2.text {
                
                passAlert()
            }
            else{
                successAlert()
            }
            
            
        }
        
      
        
    }
    
    
    func successAlert(){
        
        let alert = UIAlertController(title: "Success", message: "Success Login", preferredStyle: UIAlertController.Style.alert)
        let okButton =  UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(okButton)
        self.present(alert, animated: true , completion: nil)
        
    }
    
    func passAlert(){
        
        let alert = UIAlertController(title: "Warning", message: "Please use same Password", preferredStyle: UIAlertController.Style.alert)
        let okButton =  UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(okButton)
        self.present(alert, animated: true , completion: nil)
        
    }
    
    func warningAlert(){
        
        let alert = UIAlertController(title: "Warning", message: "Please use correct values", preferredStyle: UIAlertController.Style.alert)
        let okButton =  UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(okButton)
        self.present(alert, animated: true , completion: nil)
        
    }
    
    
    func alertFunc(){
       
        let alert = UIAlertController(title: "Error", message: "Wrong password", preferredStyle: UIAlertController.Style.alert)
        let okButton =  UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(okButton)
        self.present(alert, animated: true , completion: nil)
        
    }
}

