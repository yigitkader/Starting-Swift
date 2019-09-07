//
//  FeedVC.swift
//  FirebaseInstaClone
//
//  Created by calzom on 7.09.2019.
//  Copyright © 2019 YigitKader. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    //LOG OUT OPERATION
    @IBAction func logOutButton(_ sender: Any) {
        
        //remove remember me
        UserDefaults.standard.removeObject(forKey: "user")
        UserDefaults.standard.synchronize()
        
        let sign = self.storyboard?.instantiateViewController(withIdentifier: "sign") as! SignVC
        
        let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = sign
        
        appDelegate.rememberUser()
        
        do{
            
            try Auth.auth().signOut()
        }
        catch{
            
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
}

