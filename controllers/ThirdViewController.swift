//
//  ThirdViewController.swift
//  controllers
//
//  Created by Kenny on 2/15/20.
//  Copyright © 2020 Kenny. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    var myMessage = ""
    
    @IBOutlet weak var tvMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tvMessage.text = myMessage
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func OnChangeController(_ sender: UIButton) { 
//        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
//        let fourController = storyBoard.instantiateViewController(withIdentifier: K.id_FourController) as! FourViewController
//        self.present(fourController, animated: true, completion: nil)
        
        self.performSegue(withIdentifier: K.id_FourController, sender: self)
    }
    
    @IBAction func OnPressedExit(_ sender: UIButton) {
//        self.dismiss(animated: true, completion: nil)
        exit(0)
    }
    
    @IBAction func OnBackPressed(_ sender: UIButton) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    } 
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       print("cambiando de ventana ------")
    }
}
