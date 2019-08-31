//
//  ViewController.swift
//  BirthdayNote
//
//  Created by calzom on 9.08.2019.
//  Copyright © 2019 YigitKader. All rights reserved.
//



import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        checkDatas()
        
    }

    
    
    
    // CHECK DATABASE AND BRING DATAS
    func checkDatas(){
        
        
        let storedName = UserDefaults.standard.object(forKey: "name")
        let storedBirthday = UserDefaults.standard.object(forKey: "birthday")
        
        // İf we convert data from any , we can use ' as '
        
        if let newStoredName = storedName as? String {
            
            nameLabel.text = "Name: " + newStoredName
            
        }
        
        if let newStoredBirthday = storedBirthday as? String {
            
            birthdayLabel.text = "Birthday: \(newStoredBirthday)"
        }
        
    }
    
    
    //ADD BUTTON
    @IBAction func addButton(_ sender: Any) {
        
        if nameTextField.text?.isEmpty == false && birthdayTextField.text?.isEmpty == false {
           
            nameLabel.text = "Name: " + nameTextField.text!
            birthdayLabel.text = "Birthday: " +  birthdayTextField.text!
            
            /* This is same with up
             
                nameLabel.text = "Name:  \(nameTextField.text!) "
                birthdayLabel.text = "Birthday:  \(birthdayTextField.text!) "
            */
          
            
            /* SMALL DATABASE SYSTEM
            
            When we use small datas we can use this code in program for hiding datas
             */
            
            UserDefaults.standard.set(nameTextField.text, forKey: "name")
            UserDefaults.standard.set(birthdayTextField.text, forKey: "birthday")
            //Syncoronize and save in UserDefaults
            UserDefaults.standard.synchronize()

            
        }
       
    }
    
    
    //DELETE BUTTON
    @IBAction func deleteButton(_ sender: Any) {
        
        let storedName = UserDefaults.standard.object(forKey: "name")
        let storedBirthday = UserDefaults.standard.object(forKey: "birthday")
   
        
        if (storedName as? String) != nil {
            
            //delete object
            UserDefaults.standard.removeObject(forKey: "name")
            UserDefaults.standard.synchronize()
            nameLabel.text = "Name: "
            
        }
        
        if (storedBirthday as? String) != nil {
            
            //delete object
            UserDefaults.standard.removeObject(forKey: "birthday")
            UserDefaults.standard.synchronize()
            birthdayLabel.text = "Birthday: "
        }
        
    }
}

