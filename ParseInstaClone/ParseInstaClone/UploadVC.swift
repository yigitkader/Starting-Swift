//
//  SecondViewController.swift
//  ParseInstaClone
//
//  Created by calzom on 9.09.2019.
//  Copyright © 2019 YigitKader. All rights reserved.
//

import UIKit
import Parse
import FontAwesome_swift

class UploadVC: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var postButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        postButton.isEnabled = false
        

        
    }

    @IBAction func chosePicButton(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
        
    }
    

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imageView.image = info[.originalImage] as! UIImage
        
        self.dismiss(animated: true, completion: nil)
        
        postButton.isEnabled = true
        
    }
    
    
    //HIDE KEYBOARD AFTER TYPING
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.endEditing(true)
    }
    
    
    @IBAction func postButton(_ sender: Any) {
        
        postButton.isEnabled = false
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
         
            if commentText.text != "" {
                
            
                let object = PFObject(className: "Posts")
                
                let pfImage = PFFileObject(name: "image", data: data)
                
                let uuid = UUID().uuidString
                let uuidPost = "\(uuid) \(PFUser.current()?.username!)"
                
                
                object["postimage"] = pfImage
                object["postcomment"] = commentText.text
                object["postowner"] = PFUser.current()?.username
                object["postuuid"] = uuidPost
                
                object.saveInBackground { (success, error) in
                    
                    if error != nil {
                    
                        let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                        
                        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                        
                        alert.addAction(okButton)
                        self.present(alert, animated: true, completion: nil)
                        
                        
                    }else{
                        self.commentText.text = ""
                        self.tabBarController?.selectedIndex = 0
                        
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newPost"), object: nil)
                    
                    }
                }
                
              
                }
                
                else{
                    let alert = UIAlertController(title: "Error", message: "Please add comment", preferredStyle: UIAlertController.Style.alert)
                
                    let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                
                
                }
                
            }
            else{
            
                let alert = UIAlertController(title: "Error", message: "Please choose a photo", preferredStyle: UIAlertController.Style.alert)
            
                let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
            
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            
            
            
            }
        
            self.postButton.isEnabled = true
        
        }
    
        
        
        
        
    }
    
    
    
    
    



