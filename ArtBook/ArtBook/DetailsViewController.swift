//
//  DetailsViewController.swift
//  ArtBook
//
//  Created by calzom on 2.09.2019.
//  Copyright © 2019 YigitKader. All rights reserved.
//

import CoreData
import UIKit

class DetailsViewController: UIViewController , UIImagePickerControllerDelegate ,  UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var paintingNameLabel: UITextField!
    @IBOutlet weak var artistNameLabel: UITextField!
    @IBOutlet weak var dateLabel: UITextField!
    
    
    var selectedPaint = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //FILTER OPERATION
        
        if selectedPaint != "" {
            
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            
            // find the what is equal selectedpaint -- Filter
            fetchRequest.predicate =  NSPredicate(format: "name = %@", self.selectedPaint)
            
            fetchRequest.returnsObjectsAsFaults = false
            
            do{
                
                let results = try context.fetch(fetchRequest)
                
                if results.count > 0 {
                    
                    for result in results as! [NSManagedObject] {
                        
                        if let name = result.value(forKey: "name") as? String {
                            
                            paintingNameLabel.text = name
                        }
                        
                        if let artist = result.value(forKey: "artist") as? String {
                            
                            artistNameLabel.text = artist
                        }
                        
                        if let date = result.value(forKey: "year") as? Int {
                            
                            dateLabel.text = String(date)
                        }
                        
                        if let imageData = result.value(forKey: "image") as? Data {
                            
                            let image = UIImage(data: imageData)
                            imageView.image = image
                            
                        }
                        
                    }
                }
                
            }catch{
                
            }
            
            
            
            
        }
        
        
        
        imageView.isUserInteractionEnabled = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.selectImage))
        imageView.addGestureRecognizer(gestureRecognizer)
        
        
        paintingNameLabel.text = selectedPaint
        
        
    }
    
    @objc func selectImage(){
        
        
        /* !!!
            Dont forget to permission for camera
         */
        
        // choosing photo
        let picker = UIImagePickerController()
        picker.delegate = self
        
        //source
        //picker.sourceType = .camera
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        
        //show to picker to user
        present(picker, animated: true, completion: nil)
        
    }
    
    //WHATS GONNA HAPPEN AFTER THE USER SELECT PHOTO FROM GALLERY
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // this function givin a dictionary to us
        
        
        //getting image to imageview
        imageView.image = info[.originalImage] as? UIImage
        
        //close pic
        self.dismiss(animated: true, completion: nil)
        
        
        
    }
    
    
    
    //  CONTROL ->> !!! CHECK DATE CODE !!!
    
    @IBAction func addButton(_ sender: Any) {
        
        
        //reacching appdelegate and context
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //creating new object
        let newArt = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)

        //attributes
        if artistNameLabel.text != "" && paintingNameLabel.text != "" {
            newArt.setValue(artistNameLabel.text, forKey: "artist")
            newArt.setValue(paintingNameLabel.text, forKey: "name")
            
            
            //check ınteger
            if dateLabel.text != ""{
            if let num = Int(dateLabel.text!)  {
                
                
                    
                    //set year
                    newArt.setValue(num, forKey: "year")
                    
                    //set image
                
                
                if imageIsNullOrNot(imageName: imageView.image!) {
                    //image is not null
                    
                    let data = imageView.image?.jpegData(compressionQuality: 0.5) // reduce size half
                    newArt.setValue(data, forKey: "image")
                }
                else
                {
                    // image is null
                    emptyAlert()
                }
                
                
                    
                    
                    
                    do {
                        
                        try context.save()
                        print("no error")
                        
                    }catch{
                        
                        //show alert to user
                        warningAlert()
                        print("error")
                    }
                    
                    
                    
                }
                else{
                    checkIntegerAlert()
                    print("error")
                }
                
            }
            else{
                
                emptyAlert()
//                checkIntegerAlert()
                print(" error")
            }
            
            
            
        }
        else {
            emptyAlert()
            print("error")
        }
        
        
        //Update table view
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newPainting"), object: nil)
        
        // Go back the the previous page
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
    
    //IMAGE CONTROL FUNCTION
    func imageIsNullOrNot(imageName : UIImage)-> Bool
    {
        
        let size = CGSize(width: 0, height: 0)
        if (imageName.size.width == size.width)
        {
            return false
        }
        else
        {
            return true
        }
    }
    
    
    //ALERTS
    
    func emptyAlert(){
        
        let alert = UIAlertController(title: "Warning", message: "Please dont use blank characters and photos ", preferredStyle: UIAlertController.Style.alert)
        let okButton =  UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(okButton)
        self.present(alert, animated: true , completion: nil)
        
    }
    
    func warningAlert(){
        
        let alert = UIAlertController(title: "Error", message: "İt couldnt save", preferredStyle: UIAlertController.Style.alert)
        let okButton =  UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(okButton)
        self.present(alert, animated: true , completion: nil)
        
    }
    
    func checkIntegerAlert(){
        
        let alert = UIAlertController(title: "Error", message: "Please enter just Date", preferredStyle: UIAlertController.Style.alert)
        let okButton =  UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(okButton)
        self.present(alert, animated: true , completion: nil)
        
    }
    
    
    
    // END OF ALERTS ----------------
    
    
    
    
    
}
