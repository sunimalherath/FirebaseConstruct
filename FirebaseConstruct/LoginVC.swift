//
//  LoginVC.swift
//  FirebaseConstruct
//
//  Created by Sunimal Herath on 1/3/20.
//  Copyright © 2020 Sunimal Herath. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    // IBOutlets
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // IBActions
    @IBAction func loginBtnWasPressed(_ sender: Any) {
    }
    @IBAction func registerBtnWasPressed(_ sender: Any) {
        if usernameTextField.text != "" || passwordTextField.text != "" {
            Auth.auth().createUser(withEmail: usernameTextField.text!, password: passwordTextField.text!) { (result, error) in
                if error != nil {
                    print(error!)
                }
                else {
                    print("Account created")
                }
            }
        }
    }
}

