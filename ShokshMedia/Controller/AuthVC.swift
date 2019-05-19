//
//  AuthVC.swift
//  ShokshMedia
//
//  Created by Mahmoud Elshakoushy on 4/23/19.
//  Copyright © 2019 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func emailBtnPressed(_ sender: Any) {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        present(loginVC!, animated: true, completion: nil)
    }
    
    @IBAction func googleBtnPressed(_ sender: Any) {
    }
    
    @IBAction func fbBtnPressed(_ sender: Any) {
    }
    
}
