//
//  SignVC.swift
//  FirebaseInstaClone
//
//  Created by calzom on 7.09.2019.
//  Copyright © 2019 YigitKader. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage


class SignVC: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    //SIGN IN
    @IBAction func signInButton(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != "" {
         
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (userData, error) in
                
                if error != nil {
                 
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                    
                }
                else{
                    
                    
                    
                    //REMEMBER ME OPERATION
                    self.rememberMe()
                    
                    
                }
            }
        }
        else{
            
            let alert = UIAlertController(title: "Error", message: "username/pass", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
        
        //performSegue(withIdentifier: "toTabBarVC", sender: nil)
    }
    
    //SIGN UP
    @IBAction func signUpButton(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != "" {
            
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (userData, error) in
            
                if error != nil {
                    
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                    
                }else{
                    //no error
                    
                    self.rememberMe()
                    
                }
            }
        }
        else{
            userSignUpAlert()
        }
        
        
            
            
        }
    
    
    
    
    
    func userSignUpAlert() {
        
        let alert = UIAlertController(title: "Error", message: "Username/Password", preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func rememberMe(){
        UserDefaults.standard.set(emailText.text , forKey: "user")
        UserDefaults.standard.synchronize()
        
        //call function from appdelegate -- like segue
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.rememberUser()
    }
    
}
