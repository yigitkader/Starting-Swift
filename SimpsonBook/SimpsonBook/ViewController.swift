//
//  ViewController.swift
//  SimpsonBook
//
//  Created by calzom on 2.09.2019.
//  Copyright © 2019 YigitKader. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var mySimpsonArray = [Simpson]()
    var chosenSimpson = Simpson()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        //Simpson Class
        let bart = Simpson()
        bart.name = "Bart"
        bart.bio = "Student"
        bart.image = UIImage(named: "bart.png")!

        let homer = Simpson()
        homer.name = "Homer"
        homer.bio = "Safety Inspector"
        homer.image = UIImage(named: "homer.png")!
        
        let lisa = Simpson()
        lisa.name = "Lisa"
        lisa.bio = "Student"
        lisa.image = UIImage(named: "lisa.png")!
        
        let maggie = Simpson()
        maggie.name = "Maggie"
        maggie.bio = "Singer"
        maggie.image = UIImage(named: "maggie.png")!
        
        let marge = Simpson()
        marge.name = "Marge"
        marge.bio = "Homermaker"
        marge.image = UIImage(named: "marge.png")!
        
       
        //Simpson Array
        mySimpsonArray.append(bart)
        mySimpsonArray.append(homer)
        mySimpsonArray.append(lisa)
        mySimpsonArray.append(maggie)
        mySimpsonArray.append(marge)
        
        
        
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        chosenSimpson = mySimpsonArray[indexPath.row]
        
        
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetailsVC" {
            
            let destinationVC = segue.destination as! DetailsViewController
           
            destinationVC.selectedSimpson = chosenSimpson
            
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mySimpsonArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        //İt is return an object so we are adding their properties end of the line
        cell.textLabel?.text = mySimpsonArray[indexPath.row].name
        return cell
    }

    
}

