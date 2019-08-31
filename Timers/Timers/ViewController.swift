//
//  ViewController.swift
//  Timers
//
//  Created by calzom on 31.08.2019.
//  Copyright © 2019 YigitKader. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    
    var timer = Timer()
    
    var  counter = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        timeLabel.text = String(counter)
        
       
        timer =  Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerFunction), userInfo: nil, repeats: true)
        
        
    }

    @objc func timerFunction(){
        
        timeLabel.text = String(counter)
        
        counter -= 1
        
        if counter == 0 {
            timer.invalidate()
            timeLabel.text = "Time is Off"
            
        }
        
        
        
    }
    

}

