//
//  UploadVC.swift
//  FirebaseInstaClone
//
//  Created by calzom on 7.09.2019.
//  Copyright © 2019 YigitKader. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseAuth
import FirebaseDatabase

class UploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var picLabel: UILabel!
    
    
    var newImage = UIImage(named: "cam.png")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picLabel.isUserInteractionEnabled = true
        
        
        //imageview tap settings
        //imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.chooseImage))
        picLabel.addGestureRecognizer(gestureRecognizer)
        
        
        
    }
    
    
    @objc func chooseImage(){
    
        let picker = UIImagePickerController()
        picker.delegate =  self
        
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
        
    
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imageView.image = info[.originalImage] as? UIImage
        
        self.dismiss(animated: true, completion: nil)
    }

    
    
    //UPLOAD OPERATIONS
    @IBAction func postButton(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        //create media folder
        let mediaFolder = storageRef.child("media") //go to subdirectory
        
        
        
        
        //convert image
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            
            
            
            //Different pic names
            //uniqe id for each person
            let uuid = NSUUID().uuidString
            
            let mediaImagesRef = mediaFolder.child("\(uuid).jpg")
            mediaImagesRef.putData(data, metadata: nil) { (metaData, error) in
                
                if error != nil {
                 
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)

                    
                }
                else{ //no error
                   
                    
                    //SAVE TO DATABASE
                    
                    mediaImagesRef.downloadURL(completion: { (url, error) in
                        
                        if error == nil {   //no error
                           
                            
                            //check control
                            //print("url : \(url?.absoluteString)")
                            
                            
                            //Database process
                            
                            let databaseReference =  Database.database().reference()
                            
                            let imageURL = url?.absoluteString
                            
                            
                            //Comment text control
                            if self.commentText.text == "" {
                                let alert = UIAlertController(title: "Error", message: "Dont leave blank comment", preferredStyle: UIAlertController.Style.alert)
                                let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                                alert.addAction(okButton)
                                self.present(alert, animated: true, completion: nil)
                            }
                            else{
                                
                                let post = ["image" : imageURL! , "postedby" : Auth.auth().currentUser?.email!, "postcomment" : self.commentText.text!, "uuid" : uuid] as [String : Any]
                                
                                databaseReference.child("users").child((Auth.auth().currentUser?.uid)!).child("Post").childByAutoId().setValue(post)
                                
                                
                                
                                self.imageView.image = UIImage(named: "")
                                self.commentText.text = ""
                                //self.successAlert()
                                
                                //change the tab
                                self.tabBarController?.selectedIndex = 0
                                
                                
                                
                            }
                           
                            
                            
                            
                            
                            
                            
                        }
                        else{
                            
                            let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                            alert.addAction(okButton)
                            self.present(alert, animated: true, completion: nil)
                        }
                    })
                    
                    
                }
            }
        }
        
            // No Pic Data
        else{
            let alert = UIAlertController(title: "Error", message: "Please choose a Photo", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
        
        
        
        
    }
    
    
    
    func successAlert(){
        
        let alert = UIAlertController(title: "Success", message: "Post is shared", preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}

