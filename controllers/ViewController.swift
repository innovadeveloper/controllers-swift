//
//  ViewController.swift
//  controllers
//
//  Created by Kenny on 2/15/20.
//  Copyright © 2020 Kenny. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let isSkipController = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = "Root View"
        
        if(isSkipController){
            let storyBoard = UIStoryboard(name: "Main", bundle:nil)
            let thirdController = storyBoard.instantiateViewController(withIdentifier: K.id_ThirdController) as! ThirdViewController
            thirdController.myMessage = "nuevo mundo"
            self.presentInFullScreen(thirdController, animated: false)
        }else{
            
        }
    }

    @IBAction func OnPressedSiguiente(_ sender: UIButton) {
        print("cargar siguiente controlador..")
        performSegue(withIdentifier: K.id_SecondController, sender: self)
    }
    
    @IBAction func onPressedSiguienteByCode(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let thirdViewController = storyBoard.instantiateViewController(withIdentifier: K.id_ThirdController) as! ThirdViewController
        thirdViewController.myMessage = "nuevo mundo x2"
        self.navigationController?.pushViewController(thirdViewController, animated:true)
//        performSegue(withIdentifier: K.id_SecondController, sender: self)
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let backItem = UIBarButtonItem()
//        backItem.title = "Back"
//        navigationItem.backBarButtonItem = backItem
//    }
    @IBAction func onPressedAnotherVC(_ sender: UIButton) {
//        self.performSegue(withIdentifier: K.id_FourController, sender: self)
        
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let thirdController = storyBoard.instantiateViewController(withIdentifier: K.id_ThirdController) as! ThirdViewController
        thirdController.myMessage = "nuevo mundo"
//        thirdController.modalPresentationStyle = .fullScreen
//        self.present(thirdController, animated: true, completion: nil)
        
        
        self.presentInFullScreen(thirdController, animated: true)

    }

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
        print("cambiando de ventana 1")
     }
}

