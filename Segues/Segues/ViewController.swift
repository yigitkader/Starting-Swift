//
//  ViewController.swift
//  Segues
//
//  Created by calzom on 9.08.2019.
//  Copyright © 2019 YigitKader. All rights reserved.
//


/*
 Segues helps us for working with so many windows, pages
 */


import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var inputTextField: UITextField!
    var userName = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //TRANSFER TO DATAS
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "fromFirstToSecond" {
            
            //* we saved to SecondViewController like a variable and we can reach the all things in this page
            let destinationVC = segue.destination as! SecondViewController
            
            destinationVC.name = userName
        }
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        if let nName = inputTextField.text as? String {
            
            userName = nName
            
        }
        
        //Creating segue -> change the page
        performSegue(withIdentifier: "fromFirstToSecond", sender: nil)
        
        
    }
    
}

