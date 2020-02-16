//
//  PersonCalloutView.swift
//  controllers
//
//  Created by Kenny on 2/16/20.
//  Copyright © 2020 Kenny. All rights reserved.
//

import UIKit

protocol PersonDetailMapViewDelegate: class {
    func detailsRequestedForPerson(person: Person)
}

class PersonCalloutView: UIView
{
    weak var delegate: PersonDetailMapViewDelegate?
    var person : Person!
    @IBOutlet weak var btnBackgroundContentView: UIButton! 
    
    @IBOutlet weak var tvDescripcion: UILabel!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib() 
        // appearance 
        btnBackgroundContentView.applyArrowDialogAppearanceWithOrientation(arrowOrientation: .down)
    }
    
    func configurePerson(person : Person){
        self.person = person
        tvDescripcion.text = self.person.description
    }
    
    @IBAction func onVerMasPressed(_ sender: UIButton) {
        delegate?.detailsRequestedForPerson(person: person)
    }
    
}
 
