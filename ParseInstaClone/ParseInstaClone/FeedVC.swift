//
//  FirstViewController.swift
//  ParseInstaClone
//
//  Created by calzom on 9.09.2019.
//  Copyright © 2019 YigitKader. All rights reserved.
//

import UIKit
import Parse



class FeedVC: UIViewController, UITableViewDelegate , UITableViewDataSource {
 
    
    
    
    var postOwnerArray = [String]()
    var postCommentArray = [String]()
    var postUuidArray = [String]()
    var postImageArray = [PFFileObject]()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getData()
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.getData), name: NSNotification.Name(rawValue: "newPost"), object: nil)
    }
    
    
    
    @objc func getData(){
        
        
        postOwnerArray.removeAll(keepingCapacity: false)
        postCommentArray.removeAll(keepingCapacity: false)
        postUuidArray.removeAll(keepingCapacity: false)
        postImageArray.removeAll(keepingCapacity: false)
        
        
        
        let query = PFQuery(className: "Posts")
        
        //sortin to date
        query.addDescendingOrder("createdAt")
        
        query.findObjectsInBackground { (objects, error) in
            
            if error != nil {
                
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                
                let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                
            }else{
                
                self.postOwnerArray.removeAll(keepingCapacity: false)
                self.postCommentArray.removeAll(keepingCapacity: false)
                self.postUuidArray.removeAll(keepingCapacity: false)
                self.postImageArray.removeAll(keepingCapacity: false)
                
                if objects!.count > 0 {
                    
                    for object in objects! {
                        
                        self.postOwnerArray.append(object.object(forKey: "postowner") as! String)
                        self.postCommentArray.append(object.object(forKey: "postcomment") as! String)
                        self.postUuidArray.append(object.object(forKey: "postuuid") as! String)
                        self.postImageArray.append(object.object(forKey: "postimage") as! PFFileObject)
                        
                        
                        
                        
                    }
                    
                    self.tableView.reloadData()
                }
            }
        }
        
        
    }
    
    
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return postOwnerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        
        cell.usernameLabel.text = postOwnerArray[indexPath.row]
        cell.commentLabel.text = postCommentArray[indexPath.row]
        cell.uuidLabel.text = postUuidArray[indexPath.row]
        
        
        postImageArray[indexPath.row].getDataInBackground { (data, error) in
            
            if error != nil {
                
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                
                let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                
            }else{
                //no error
                
                cell.postImage.image = UIImage(data: data!)
                
                
                
            }
        }
        
        return cell
    }
    
    
    //LOG OUT FUNCTION
    @IBAction func signOutButton(_ sender: Any) {
        
        
        
        PFUser.logOutInBackground { (error) in
            
            if error != nil {
                
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                
                let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                
            }
            else{
                
                //remove rememberme
                UserDefaults.standard.removeObject(forKey: "username")
                UserDefaults.standard.synchronize()
                
                let sign = self.storyboard?.instantiateViewController(withIdentifier: "sign") as! SignVC
                
                let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                
                appDelegate.window?.rootViewController = sign
                
                appDelegate.rememberMe()
                
                
            }
        }
        
       
        
        
        
        
    }
    
    
    
    
}

