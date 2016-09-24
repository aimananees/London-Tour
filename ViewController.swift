//
//  ViewController.swift
//  GoogleSDK
//
//  Created by Aiman Abdullah Anees on 22/09/16.
//  Copyright © 2016 Aiman Abdullah Anees. All rights reserved.
//

import UIKit
import GoogleMaps

class VacationDestination: NSObject{
    let name: String
    let location: CLLocationCoordinate2D
    let zoom: Float
    
    init(name:String, location:CLLocationCoordinate2D, zoom: Float){
        self.name = name
        self.location = location
        self.zoom = zoom
        
    }
    
}


class ViewController: UIViewController {
    
        
    var mapView: GMSMapView!
    
    let destination = [VacationDestination(name: "London Eye", location: CLLocationCoordinate2DMake(51.5033, -0.1195), zoom: 16),VacationDestination(name: "Tower Bridge", location: CLLocationCoordinate2DMake(51.5055, -0.0754), zoom: 16),VacationDestination(name: "Big Ben", location: CLLocationCoordinate2DMake(51.5007, -0.1246), zoom: 16),VacationDestination(name: "The Shard", location: CLLocationCoordinate2DMake(51.5045, -0.0865), zoom: 16)]
    
    var currentDestination: VacationDestination!
    
        
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Setting up MapView
        let camera = GMSCameraPosition.camera(withLatitude: 51.5014, longitude: -0.1419, zoom: 16)
        mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.isMyLocationEnabled = true
        self.view = mapView
        
        //To set the default location
        let currentLocation = CLLocationCoordinate2DMake(51.5014, -0.1419)
        //To make a marker at the current location
        let  marker = GMSMarker(position: currentLocation)
        marker.title = "Buckingham Palace"
        marker.map = mapView
        
        //Creates Button
        navigationItem.rightBarButtonItem=UIBarButtonItem(title: "Next", style: .plain, target: self, action: "next")
        navigationItem.title = "Buckingham Palace"
        
    }
    
    func next(){
        
        
        if currentDestination == nil{
            currentDestination = destination.first
            navigationItem.title = currentDestination.name
            //This will help us to move to next location without any proper animations
            //mapView.camera = GMSCameraPosition.camera(withTarget: currentDestination.location, zoom: currentDestination.zoom)
            
            //To delay a command-place it between a block of code you want to delay
            CATransaction.begin() //This begins to delay the desired block of code
            CATransaction.setValue(2, forKey: kCATransactionAnimationDuration)
            //Type the block of code..
            
            
            //This is used for smoother view(better than the previous option)
            mapView.animate(to: GMSCameraPosition.camera(withTarget: currentDestination.location, zoom: currentDestination.zoom))
            
            CATransaction.commit() // Commits the transaction
            
            let  marker = GMSMarker(position: currentDestination.location)
            marker.title = currentDestination.name
            marker.map = mapView

            
        }
        
        else{
            if let index = destination.index(of: currentDestination){
                currentDestination = destination[index+1]
                navigationItem.title = currentDestination.name
                
                CATransaction.begin()
                CATransaction.setValue(2, forKey: kCATransactionAnimationDuration)
                mapView.animate(to: GMSCameraPosition.camera(withTarget: currentDestination.location, zoom: currentDestination.zoom))
                CATransaction.commit()

                
                let  marker = GMSMarker(position: currentDestination.location)
                marker.title = currentDestination.name
                marker.map = mapView

                
            }
            
        }
        
    }
    

    


}

