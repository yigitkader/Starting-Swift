//
//  ViewController.swift
//  TravelMapBook
//
//  Created by calzom on 3.09.2019.
//  Copyright © 2019 YigitKader. All rights reserved.
//

import UIKit
import CoreData

class TableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var tableView: UITableView!
    
    var titleArray = [String]()
    var subtitleArray = [String]()
    var latitudeArray = [Double]()
    var longitudeArray = [Double]()
    
    
    var selectedTitle = ""
    var selectedSubtitle = ""
    var selectedLatitude : Double = 0
    var selectedLongitude : Double = 0
     
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        fetchData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {

        NotificationCenter.default.addObserver(self, selector: #selector(self.fetchData), name: NSNotification.Name("updateTableView"), object: nil)
    }
    
    
    //BRING DATAS FROM DATABASE
    @objc func fetchData(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
        request.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(request)
            
            if results.count > 0 {
                
                self.titleArray.removeAll(keepingCapacity: false)
                self.subtitleArray.removeAll(keepingCapacity: false)
                self.latitudeArray.removeAll(keepingCapacity: false)
                self.longitudeArray.removeAll(keepingCapacity: false)
                
                for result in results as! [NSManagedObject] {
                    
                    if let title = result.value(forKey: "title") as? String {
                        titleArray.append(title)
                    }
                    
                    if let subtitle = result.value(forKey: "subtitle") as? String {
                        subtitleArray.append(subtitle)
                    }
                    
                    if let latitude = result.value(forKey: "latitude") as? Double {
                        latitudeArray.append(latitude)
                    }
                    
                    if let longitude = result.value(forKey: "longitude") as? Double {
                        longitudeArray.append(longitude)
                    }
                }
                
                //reload tableview datas
                self.tableView.reloadData()
            }
            
            
        }catch{
            
            print("error")
        }
        
        
        
    }
    
    
    
    //DELETE OPERATION
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
            
            
            do{
                
                let results = try context.fetch(fetchRequest)
                
                for result in results as! [NSManagedObject] {
                    
                    if let  title = result.value(forKey: "title") as? String {
                        
                        if title == titleArray[indexPath.row] {
                            
                            context.delete(result)
                            titleArray.remove(at: indexPath.row)
                            subtitleArray.remove(at: indexPath.row)
                            latitudeArray.remove(at: indexPath.row)
                            longitudeArray.remove(at: indexPath.row)
                            self.tableView.reloadData()
                            
                            
                            do{
                                try context.save()
                            }catch{
                                
                            }
                        
                            break
                        }
                    }
                    
                }
                
            }catch{
                
                
            }
        }
    }
    
    
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        selectedTitle = titleArray[indexPath.row]
        selectedSubtitle = subtitleArray[indexPath.row]
        selectedLatitude = latitudeArray[indexPath.row]
        selectedLongitude = longitudeArray[indexPath.row]
        
        performSegue(withIdentifier: "toMapVC", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toMapVC" {
            
            let destinationVC = segue.destination as! MapVC
            
            destinationVC.givenTitle = selectedTitle
            destinationVC.givenSubtitle = selectedSubtitle
            destinationVC.givenLatitude = selectedLatitude
            destinationVC.givenLongitude = selectedLongitude
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return titleArray.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = titleArray[indexPath.row]
        return cell
    }
    
    @IBAction func addButton(_ sender: Any) {
        
        
        selectedTitle = ""
        performSegue(withIdentifier: "toMapVC", sender: nil)
    }
    
}
