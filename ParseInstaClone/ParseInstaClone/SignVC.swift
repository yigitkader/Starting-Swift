//
//  SignVC.swift
//  ParseInstaClone
//
//  Created by calzom on 9.09.2019.
//  Copyright © 2019 YigitKader. All rights reserved.
//

import UIKit
import Parse


class SignVC: UIViewController {

    
    @IBOutlet weak var signNickLabel: UITextField!
    @IBOutlet weak var signPassLabel: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /* SAVE DATAS
        let parseObject = PFObject(className: "Fruits")
        parseObject["name"] = "cherry"
        parseObject["calories"] = "20"
        
        parseObject.saveInBackground { (success, error) in
            
            if error != nil {
                
                print(error?.localizedDescription)
            }
            else{
                print("saved")
            }
        } */
        
        
        
        
        
       /* BRING DATAS
        let query = PFQuery(className: "Fruits")
        
        //filter
        query.whereKey("calories", greaterThan: "30")
        //query.whereKey("name", equalTo: "cherry")
        
        query.findObjectsInBackground { (objects, error) in
            
            
            if error != nil {
                
                print(error?.localizedDescription)
            }
            else{
                print(objects!)
            }
        } */
        
        
        
        
    }
    

    @IBAction func signInButton(_ sender: Any) {
        
        let user = PFUser()
        
        
        if signNickLabel.text != "" && signPassLabel.text != "" {
            
            user.username = signNickLabel.text
            user.password = signPassLabel.text
            
            PFUser.logInWithUsername(inBackground: signNickLabel.text!, password: signPassLabel.text!) { (user, error) in
                
                if error != nil {
                    
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    
                    let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                    
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    
                    self.performSegue(withIdentifier: "toTabBar", sender: nil)
                    
                }
            }
            
            
        }
        else{
            
            let alert = UIAlertController(title: "Error", message: "Do not use blank charachters", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
            
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
            
        }
        
        
        
        
        
    }
    
    
    @IBAction func signUpButton(_ sender: Any) {
        
        let user = PFUser()
      
        
        if signNickLabel.text != "" && signPassLabel.text != "" {
            
            user.username = signNickLabel.text
            user.password = signPassLabel.text
            
            user.signUpInBackground { (success, error) in
                
                if error != nil {
                    
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    
                    let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                    
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                }
                else{//no error
                    
                    self.performSegue(withIdentifier: "toTabBar", sender: nil)
                    
                }
            }
        }
        else{
            
            let alert = UIAlertController(title: "Error", message: "Do not use blank charachters", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
            
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
            
        }
        
        
    }
    

}
