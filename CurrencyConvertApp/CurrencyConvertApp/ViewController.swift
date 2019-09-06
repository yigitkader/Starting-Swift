//
//  ViewController.swift
//  CurrencyConvertApp
//
//  Created by calzom on 6.09.2019.
//  Copyright © 2019 YigitKader. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    //GET RATES
    @IBAction func getRatesButton(_ sender: Any) {
        
        
        //Important! -> when we use working without https then take permisson -> (App transport security settings->allow artbitrary loadings)
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=e6022b3b2c670a7f331d0f37b6f74eb7")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                
                let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
                
                alert.addAction(okButton)
                self.present(alert , animated: true,completion: nil)
                
            }
            else{
                if data != nil {
                    
                   
                    
                    do {
                        
                        let JSONResult = try  JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,AnyObject>
                        
                        
                        //get datas
                        DispatchQueue.main.async {
                            
                            //print(JSONResult)
                            
                            let rates = JSONResult["rates"] as! [String : AnyObject]
                            
                            //print(rates)
                            
                            let cadM = String(describing: rates["CAD"]! )
                            self.cadLabel.text = "CAD : " + cadM
                            
                            let  chfM = String(describing: rates["CHF"]! )
                            self.chfLabel.text = "CHF : " + chfM
                            
                            let gbpM = String(describing: rates["GBP"]! )
                            self.gbpLabel.text = "GBP : " + gbpM
                            
                            let jpyM = String(describing: rates["JPY"]! )
                            self.jpyLabel.text = "JPY : " + jpyM
                            
                            let usdM = String(describing: rates["USD"]! )
                            self.usdLabel.text = "USD : " + usdM
                            
                            let turkishLira = String(describing: rates["TRY"]!)
                            self.tryLabel.text = "TRY : " + turkishLira
                            
                        }
                        
                        
                    }
                    catch{
                        
                    }
                }
            }
        }
        
        //start task
        task.resume()
        
        
    }
    
}

