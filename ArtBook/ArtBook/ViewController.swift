//
//  ViewController.swift
//  ArtBook
//
//  Created by calzom on 2.09.2019.
//  Copyright © 2019 YigitKader. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    
    
    var nameArray = [String]()
    var artistArray = [String]()
    var yearArray = [Int]()
    var imageArray = [UIImage]()
    
    var selectedPainting = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.dataSource = self
        tableView.delegate = self
        
        
        getInfo()
    }
    
    //UPDATE HOMEPAGE
    // when we see the viewcontroller page , this func reload itself . so it means update tableview
    override func viewWillAppear(_ animated: Bool) {
        
        //add an observer
        NotificationCenter.default.addObserver(self, selector: #selector(self.getInfo), name: NSNotification.Name("newPainting"), object: nil)
    }
    
    
    
    //BRING DATAS FROM DATABASE
    @objc func getInfo(){
        
        //clear stack
        nameArray.removeAll(keepingCapacity: false)
        artistArray.removeAll(keepingCapacity: false)
        yearArray.removeAll(keepingCapacity: false)
        imageArray.removeAll(keepingCapacity: false)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
    
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            //it is giving an array to us
            let results = try context.fetch(fetchRequest)
            
            
            
            
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    
                    if let name = result.value(forKey: "name") as? String {
                        self.nameArray.append(name)
                    }
                    
                    if let artist = result.value(forKey: "artist") as? String {
                        self.artistArray.append(artist)
                    }
                    
                    if let date = result.value(forKey: "year") as? Int {
                        self.yearArray.append(date)
                    }
                    
                    if let imageData = result.value(forKey: "image") as? Data {
                        let image = UIImage(data: imageData)
                        self.imageArray.append(image!)
                        
                    }
                    
                    self.tableView.reloadData()
                }
            }
            
        } catch  {
            print("error")
        }
        
    }
    
    
    //DELETE OPERATION
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            
            do {
                
                let results = try context.fetch(fetchRequest)
                
                for result in results as! [NSManagedObject] {
                    
                    if let name = result.value(forKey: "name") as? String {
                        
                        if name == nameArray[indexPath.row] {
                            context.delete(result)
                            nameArray.remove(at: indexPath.row)
                            artistArray.remove(at: indexPath.row)
                            yearArray.remove(at: indexPath.row)
                            imageArray.remove(at: indexPath.row)
                            self.tableView.reloadData()
                            
                            do {
                                    try context.save()
                            }catch{
                                
                            }
                            
                            // if we dont use this, it is gonna delete all of them
                            break
                        }
                    }
                }
            } catch{
                
                
            }
            
            
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetailsVC" {
            
            let destinationVC = segue.destination as! DetailsViewController
            
            destinationVC.selectedPaint = selectedPainting
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedPainting = nameArray[indexPath.row]
        
        performSegue(withIdentifier: "toDetailsVC", sender: nil )
    
    }
    
    
    @IBAction func addPicButton(_ sender: Any) {
        
        //send empty 
        selectedPainting = ""
        
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = nameArray[indexPath.row]
        return cell
        
    }


}

