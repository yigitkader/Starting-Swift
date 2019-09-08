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
import FirebaseDatabase
import SDWebImage


class FeedVC: UIViewController, UITableViewDelegate ,UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    
    var useremailArray = [String]()
    var usercommentArray = [String]()
    var userimageArray = [String]()
    
    var timer = Timer()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // we have to change tableview properties for show images (Property cells) and we will add new class for cell
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromFirebase()
        
    }

   
    
   @objc func getDataFromFirebase(){
    
//        self.userimageArray.removeAll(keepingCapacity: false)
//        self.useremailArray.removeAll(keepingCapacity: false)
//        self.userimageArray.removeAll(keepingCapacity: false)
    
        let databaseReference = Database.database().reference()
        
        databaseReference.child("users").observe(DataEventType.childAdded) { (snapshot) in
            
//            print("children : \(snapshot.children)")
//            print("value : \(snapshot.value)")
//            print("key : \(snapshot.key)")
            
            
            
            let values = snapshot.value! as! NSDictionary
            let post = values["Post"] as! NSDictionary
            
            let postId = post.allKeys
            
            for id in postId {
                
                let singlePost = post[id] as! NSDictionary
                
                self.usercommentArray.append(singlePost["postcomment"] as! String)
                self.useremailArray.append(singlePost["postedby"] as! String)
                self.userimageArray.append(singlePost["image"] as! String)
                self.tableView.reloadData()
                
               
            }
            
            
        }
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return useremailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FeedCell
        
        cell.useremailLabel.text =  useremailArray[indexPath.row]
        cell.usercommentLabel.text = usercommentArray[indexPath.row]
        cell.imageviewCell.sd_setImage(with: URL(string: self.userimageArray[indexPath.row]))
        
        
        return cell
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

