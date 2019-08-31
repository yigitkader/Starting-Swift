//
//  ViewController.swift
//  CatchTheKenny
//
//  Created by calzom on 31.08.2019.
//  Copyright © 2019 YigitKader. All rights reserved.
//  CREATED BY YIGIT KADER

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    var timer = Timer()
    var kennyTimer = Timer()
    
    var kennyArray = [UIImageView]()
    var score = 0
    var highScore = 0
    var counter = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //USER INTERACTION ENABLE FOR IMAGES
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        scoreLabel.text = "0"
        highScoreLabel.text = "0"
        
        
        //Adding images to array
        kennyArray.append(kenny1)
        kennyArray.append(kenny2)
        kennyArray.append(kenny3)
        kennyArray.append(kenny4)
        kennyArray.append(kenny5)
        kennyArray.append(kenny6)
        kennyArray.append(kenny7)
        kennyArray.append(kenny8)
        kennyArray.append(kenny9)
        
        //hideKennys()
        
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.increaseScore))
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(self.increaseScore))
        let gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(self.increaseScore))
        let gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(self.increaseScore))
        let gestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(self.increaseScore))
        let gestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(self.increaseScore))
        let gestureRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(self.increaseScore))
        let gestureRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(self.increaseScore))
        let gestureRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(self.increaseScore))
        
        
        kenny1.addGestureRecognizer(gestureRecognizer)
        kenny2.addGestureRecognizer(gestureRecognizer2)
        kenny3.addGestureRecognizer(gestureRecognizer3)
        kenny4.addGestureRecognizer(gestureRecognizer4)
        kenny5.addGestureRecognizer(gestureRecognizer5)
        kenny6.addGestureRecognizer(gestureRecognizer6)
        kenny7.addGestureRecognizer(gestureRecognizer7)
        kenny8.addGestureRecognizer(gestureRecognizer8)
        kenny9.addGestureRecognizer(gestureRecognizer9)
     
        //TIMER
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerFunc), userInfo: nil, repeats: true)
        
         //TIMER FUNC FOR KENNY FOR CALLING
        kennyTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(self.getKennys), userInfo: nil, repeats: true)
        
        bringHighScore()
       
    }
    
    
    //START GAME AND
   
 
    
    //BRING HIGHSCORE
    func bringHighScore(){
      
        let storedHighScore = UserDefaults.standard.object(forKey: "newhighscore")
        
        if let newStoredHighScore = storedHighScore as? String {
            
            highScoreLabel.text = String(newStoredHighScore)
            
        }
    }
    
    
    @objc func getKennys(){
        
        hideKennys()
        let randNumber = Int.random(in: 0 ..< 9)
        kennyArray[randNumber].isHidden = false
    }
    
    //TIME FUNCTION
    @objc func timerFunc(){

        timeLabel.text = String(counter)
        
        counter -= 1
        
        if counter == -1 {
            timer.invalidate()
            kennyTimer.invalidate()
            
            hideKennys()
            
            
            if Int(scoreLabel.text!)! > Int(highScoreLabel.text!)!{
            
                UserDefaults.standard.set(scoreLabel.text, forKey: "newhighscore")
                UserDefaults.standard.synchronize()
                highScoreLabel.text = scoreLabel.text
            }
            else{
                UserDefaults.standard.set(highScoreLabel.text, forKey: "newhighscore")
                UserDefaults.standard.synchronize()
                
            }
            
            
            
            timeAlert()
            
            
        }
        
    }
    
    //INCREASE SCORE FUNCTION
    @objc func increaseScore(){
        
        score += 1
        scoreLabel.text = String(score)
    }
    
    
    func hideKennys(){
        
        for item in kennyArray {
            item.isHidden = true
        }
        
    }

   
    
    //ALERT
    func timeAlert(){
        
        let alert = UIAlertController(title: "Time is Off", message: "", preferredStyle: UIAlertController.Style.alert)
        
        let okbutton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        
        let restartButton = UIAlertAction(title: "Restart", style: UIAlertAction.Style.default, handler: {( UIAlertAction)
            
            in
            
            self.score = 0
            self.scoreLabel.text = "0"
            self.counter = 10
            
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerFunc), userInfo: nil, repeats: true)
            
            self.kennyTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(self.getKennys), userInfo: nil, repeats: true)
            
            
        })
        alert.addAction(okbutton)
        alert.addAction(restartButton)
        self.present(alert, animated: true , completion: nil)
        
    }
    
    
   
    
    
    
    
}

