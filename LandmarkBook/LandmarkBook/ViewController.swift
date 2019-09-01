//
//  ViewController.swift
//  LandmarkBook
//
//  Created by calzom on 1.09.2019.
//  Copyright © 2019 YigitKader. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var landmarkNames = [String]()
    var landmarkImages = [UIImage]()
    var selectedLandmarkName = ""
    var selectedLandmarkImage = UIImage()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         if we use table view , we have to do 2 things for using.
         : datasource and delegate
         
         adding to class delegate and datasource
         
         after we need 2 important fucntion for using tableview
         :  numberOfRowsInSection , cellForRowAt
         
         */
        tableView.dataSource = self
        tableView.delegate = self
        
        
        landmarkNames.append("Colloseum")
        landmarkNames.append("Greatwall")
        landmarkNames.append("Kremlin")
        landmarkNames.append("Stonehenge")
        landmarkNames.append("Tajmahal")
        
        landmarkImages.append(UIImage(named: "colloseum.jpg")!)
        landmarkImages.append(UIImage(named: "greatwall.jpg")!)
        landmarkImages.append(UIImage(named: "kremlin.jpg")!)
        landmarkImages.append(UIImage(named: "stonehenge.jpg")!)
        landmarkImages.append(UIImage(named: "tajmahal.jpg")!)
        
        
        
        
        
        
    }

    
    // WHAT GONNA HAPPEN WHEN CHOOSE A TABLEVIEW ROW
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        selectedLandmarkName = landmarkNames[indexPath.row]
        selectedLandmarkImage = landmarkImages[indexPath.row]
        performSegue(withIdentifier: "toImageVC", sender: nil)
        
    }
    
    
    //TRANSFERING THE DATAS
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toImageVC" {
            
            // we are using detailsVC like a variable
            let destinationVC = segue.destination as! detailsViewController
            
            destinationVC.landmarkName = selectedLandmarkName
            destinationVC.landmarkImage = selectedLandmarkImage
            
        }
    }
    

    
    
    /*NECESSARY FUNCTİON FOR TABLEVIEW */
    //HOW MANY ROW COULD BE ON TABLEVIEW
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return landmarkNames.count
    }

    /*NECESSARY FUNCTİON FOR TABLEVIEW */
    // THIS FUNCTION WANTS A CELL FOR USE TABLE VIEW
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = landmarkNames[indexPath.row]
        return cell
    }
    
    
    //DELETE FUNCTİON
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            landmarkNames.remove(at: indexPath.row)
            landmarkImages.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
    }
    
    
}

