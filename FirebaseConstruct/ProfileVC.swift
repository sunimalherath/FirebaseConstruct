//
//  ProfileVC.swift
//  FirebaseConstruct
//
//  Created by Sunimal Herath on 1/3/20.
//  Copyright © 2020 Sunimal Herath. All rights reserved.
//

import UIKit
import Firebase

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
    
    // IBActions
    @IBAction func saveBtnWasPressed(_ sender: Any) {
        if nameTextField.text != "" || cityTextField.text != "" || webTextField.text != "" || bioTextView.text != "" {
            var dbRef: DatabaseReference!
            dbRef = Database.database().reference()
            let userId = Auth.auth().currentUser?.uid
            
            dbRef.child("users/" + userId! + "/name").setValue(nameTextField.text)
            dbRef.child("users/" + userId! + "/city").setValue(cityTextField.text)
            dbRef.child("users/" + userId! + "/web").setValue(webTextField.text)
            dbRef.child("users/" + userId! + "/bio").setValue(bioTextView.text)
            
            print("Profile data saved")
        }
        else {
            print("Unable to save data")
        }
    }
    @IBAction func logoutBtnWasPressed(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "goLogin", sender: self)
        }
        catch {
            print(error)
        }
    }
    
}
