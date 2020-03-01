//
//  ProfileVC.swift
//  FirebaseConstruct
//
//  Created by Sunimal Herath on 1/3/20.
//  Copyright © 2020 Sunimal Herath. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    //IBOutlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var webTextField: UITextField!
    @IBOutlet weak var bioTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func saveBtnWasPressed(_ sender: Any) {
    }
    @IBAction func logoutBtnWasPressed(_ sender: Any) {
    }
    
}
