//
//  ViewController.swift
//  TravelMapBook
//
//  Created by calzom on 3.09.2019.
//  Copyright © 2019 YigitKader. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class MapVC: UIViewController , MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var placeNameLabel: UITextField!
    @IBOutlet weak var commentLabel: UITextField!
    
    var locationManager = CLLocationManager()
    var requestCLLocation = CLLocation()
    
    var chosenLatitude =  Double()
    var chosenLongitude =  Double()
    
    
    var givenTitle = ""
    var givenSubtitle = ""
    var givenLatitude : Double = 0
    var givenLongitude : Double = 0
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        mapView.isUserInteractionEnabled = true
        
        
        getUserLocation()
        
        
        // we made with long press
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.chooseLocation(gestureRecognizer:)))
        //min second for add pin
        recognizer.minimumPressDuration = 2
        mapView.addGestureRecognizer(recognizer)
        
        
        
        if givenTitle != "" {
            
            let annotation =  MKPointAnnotation()
            
            let coordinate = CLLocationCoordinate2D(latitude: givenLatitude , longitude: givenLongitude)
            annotation.coordinate = coordinate
            annotation.title = givenTitle
            annotation.subtitle = givenSubtitle
            self.mapView.addAnnotation(annotation)
            
            placeNameLabel.text = givenTitle
            commentLabel.text = givenSubtitle
            
            
            
            
        }
        
    }

    
    
    
    //CUSTOMIZE ANNOTATION  (Pin)
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // if annotation is users annotation then do this
        if annotation is MKUserLocation {
            
            return nil
        }
        
        let reuseId =  "myAnnotation"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            
            //add info button to beside
            pinView?.canShowCallout = true
            pinView?.pinTintColor = UIColor.black //color of pinview
            
            
            let button = UIButton(type: UIButton.ButtonType.detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
            
        }
        else{
            
            pinView?.annotation = annotation
            
            
        }
        
        return pinView
    }
    
    
    
    /* -- NAVIGATION OPERATION --     WHAT GONNA HAPPEN WHEN WE CLICKED BUTTON ON ANNOTATION  */
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        
        
        
        //check coordinates
        if givenLatitude != 0 {
            
            if givenLongitude != 0 {
                
                self.requestCLLocation = CLLocation(latitude: givenLatitude, longitude: givenLongitude)
                
            }
        }
        
        CLGeocoder().reverseGeocodeLocation(requestCLLocation) { (placemarks, error) in
            
            if let placemark = placemarks {
                
                if placemark.count > 0 {
                    
                    
                    let newPlaceMark = MKPlacemark(placemark: placemark[0])
                    
                    let item = MKMapItem(placemark: newPlaceMark)
                    item.name = self.givenTitle
                    
                    let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                    item.openInMaps(launchOptions: launchOptions)
                    
                }
            }
            
            
        }
        
    }
    

    
    //SAVE PLACES TO DATABASE
    @IBAction func saveButton(_ sender: Any) {
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newPlace = NSEntityDescription.insertNewObject(forEntityName: "Places", into: context)
        newPlace.setValue(placeNameLabel.text, forKey: "title")
        newPlace.setValue(commentLabel.text, forKey: "subtitle")
        newPlace.setValue(chosenLatitude, forKey: "latitude")
        newPlace.setValue(chosenLongitude, forKey: "longitude")
        
        
        do {
            try context.save()
            print("no error")
            
        }catch{
            
            print("error")
        }
        
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateTableView"), object: nil)
        
        //go to previous page
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    
    
    
    //ADDING PIN OPERATION
    @objc func chooseLocation(gestureRecognizer : UILongPressGestureRecognizer) {
        
       if gestureRecognizer.state == UIGestureRecognizer.State.began {
            
            
            let touchedPoint = gestureRecognizer.location(in: self.mapView)
        
            let chosenCoordinates = self.mapView.convert(touchedPoint, toCoordinateFrom: self.mapView)
       
            chosenLatitude = chosenCoordinates.latitude
            chosenLongitude = chosenCoordinates.longitude
       
            let annotation = MKPointAnnotation()
            annotation.coordinate = chosenCoordinates
            annotation.title = placeNameLabel.text
            annotation.subtitle = commentLabel.text
            self.mapView.addAnnotation(annotation)
        
        }
        
        
    }
    
    
    


    /* --- FIND USER'S LOCATION -- */
    
    func getUserLocation(){
        
        /*--FIND USER'S LOCATION */
        locationManager.delegate = self
        //find the best locaciton but it use so much power
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //when we use this location? and add permisson for this
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    
    /* -- GET USERS LOCATION AND BRING AS AN ARRAY --   (NECESARRY FUNC FOR USER LOCATION) */
 
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //get latitude and longitude
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        
        //how much zoom ?
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        
        //crate region
        let region = MKCoordinateRegion(center: location, span: span)
        
        mapView.setRegion(region, animated: true)
        
        
            
            
       
    }
    
    /* END OF FIND USER LOCATION */
    
}

