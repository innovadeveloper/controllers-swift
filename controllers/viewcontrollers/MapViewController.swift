//
//  MapViewController.swift
//  controllers
//
//  Created by Kenny on 2/15/20.
//  Copyright © 2020 Kenny. All rights reserved.
//

import UIKit
import MapKit

private let kPersonWishListAnnotationName = "kPersonWishListAnnotationName"

class MapViewController: UIViewController, MKMapViewDelegate, PersonDetailMapViewDelegate{

    @IBOutlet weak var mapView: MKMapView!
    // data
    var selectedPerson: Person!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view. 
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configurePeopleInMap()
        setFakeUserPosition()
    }
    
    func configurePeopleInMap() {
        var annotations = [MKAnnotation]()
        for person in PeopleWishListManager.sharedInstance.people {
            let annotation = PersonWishListAnnotation(person: person)
            annotations.append(annotation)
        }
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(annotations)
        mapView.delegate = self
    }

    func setFakeUserPosition() {
        let visibleRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 47.57983, longitude: -52.68997), latitudinalMeters: 10000, longitudinalMeters: 10000)
        self.mapView.setRegion(self.mapView.regionThatFits(visibleRegion), animated: true)
    }
    
    // MARK: - MKMapViewDelegate methods
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let visibleRegion = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        self.mapView.setRegion(self.mapView.regionThatFits(visibleRegion), animated: true)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: kPersonWishListAnnotationName)
        
        if annotationView == nil {
            annotationView = PersonWishListAnnotationView(annotation: annotation, reuseIdentifier: kPersonWishListAnnotationName)
            (annotationView as! PersonWishListAnnotationView).personDetailDelegate = self
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
        
    }
    
    func detailsRequestedForPerson(person: Person) {
        self.selectedPerson = person
        print(self.selectedPerson.description)
    }
    
//    // MARK: - Selecting a person and seguing to details
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let pdvc = segue.destination as? PersonDetailsViewController {
//            pdvc.person = self.selectedPerson
//        }
//    }
//
//    func detailsRequestedForPerson(person: Person) {
//        self.selectedPerson = person
//        self.performSegue(withIdentifier: "personDetails", sender: nil)
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
