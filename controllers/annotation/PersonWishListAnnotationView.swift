//
//  PersonWishListAnnotationView.swift
//  CustomPinsMap
//
//  Created by Ignacio Nieto Carvajal on 6/12/16.
//  Copyright © 2016 Ignacio Nieto Carvajal. All rights reserved.
//

import UIKit
import MapKit

private let kPersonMapPinImage = UIImage(named: "mapPin")!
private let kPersonMapAnimationTime = 0.300

class PersonWishListAnnotationView: MKAnnotationView {
    // data
//    weak var personDetailDelegate: PersonDetailMapViewDelegate?
//    weak var customCalloutView: PersonDetailMapView?
//    override var annotation: MKAnnotation?
//        {
//        willSet { customCalloutView?.removeFromSuperview() }
//    }

    weak var personDetailDelegate: PersonDetailMapViewDelegate?
    weak var customCalloutView: PersonCalloutView?
    override var annotation: MKAnnotation?
        {
        willSet { customCalloutView?.removeFromSuperview() }
    }
    // MARK: - life cycle
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.canShowCallout = false
        self.image = kPersonMapPinImage
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.canShowCallout = false // This is important: Don't show default callout.
        self.image = kPersonMapPinImage
    }
    
    // MARK: - callout showing and hiding
    // Important: the selected state of the annotation view controls when the
    // view must be shown or not. We should show it when selected and hide it
    // when de-selected.
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        print("setSelected ??")
//    }
//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
////        print("hitTest 1..?")
//        if let parentHitView = super.hitTest(point, with: event) { return parentHitView }
//        else { // test in our custom callout.
//            print("hitTest 2..?")
////            if customCalloutView != nil {
////                return customCalloutView!.hitTest(convert(point, to: customCalloutView!), with: event)
////            } else { return nil }
//        }
//        return nil
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            self.customCalloutView?.removeFromSuperview() // remove old custom callout (if any)

            if let newCustomCalloutView = loadPersonDetailMapView() {
                // fix location from top-left to its right place.
                newCustomCalloutView.frame.origin.x -= newCustomCalloutView.frame.width / 2.0 - (self.frame.width / 2.0)
                newCustomCalloutView.frame.origin.y -= newCustomCalloutView.frame.height

                // set custom callout view
                self.addSubview(newCustomCalloutView)
                self.customCalloutView = newCustomCalloutView

                // animate presentation
                if animated {
//                    self.customCalloutView!.alpha = 0.0
                    self.customCalloutView!.transform = CGAffineTransform(scaleX: 0, y: 0)
                    UIView.animate(withDuration: kPersonMapAnimationTime, animations: {
                        self.customCalloutView!.transform = CGAffineTransform(scaleX: 1, y: 1)
                    })
                }
            }
        } else {
            if customCalloutView != nil {
                if animated { // fade out animation, then remove it.
                    self.customCalloutView!.transform = CGAffineTransform(scaleX: 1, y: 1)
                    UIView.animate(withDuration: kPersonMapAnimationTime, animations: {
                        self.customCalloutView!.transform = CGAffineTransform(scaleX: 0, y: 0)
                    }, completion: { (success) in
                        self.customCalloutView!.removeFromSuperview()
                    })
                } else { self.customCalloutView!.removeFromSuperview() } // just remove it.
            }
        }
    }
    
    func loadPersonDetailMapView() -> PersonCalloutView? {
        if let views = Bundle.main.loadNibNamed("PersonCalloutView", owner: self, options: nil) as? [PersonCalloutView], views.count > 0 {
            let personDetailMapView = views.first!
            personDetailMapView.delegate = self.personDetailDelegate
            if let personAnnotation = annotation as? PersonWishListAnnotation {
                let person = personAnnotation.person
                personDetailMapView.configurePerson(person: person)
            }
            return personDetailMapView
        }
        return nil
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.customCalloutView?.removeFromSuperview()
    }
    
    // MARK: - Detecting and reaction to taps on custom callout.
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        // if super passed hit test, return the result
        if let parentHitView = super.hitTest(point, with: event) { return parentHitView }
        else { // test in our custom callout.
            if customCalloutView != nil {
                return customCalloutView!.hitTest(convert(point, to: customCalloutView!), with: event)
            } else { return nil }
        }
    }
}
