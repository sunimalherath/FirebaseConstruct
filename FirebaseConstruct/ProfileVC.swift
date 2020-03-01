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
        
        loadProfileData()
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
    @IBAction func browseBtnWasPressed(_ sender: Any) {
        pickPhoto()
    }
    
    private func loadProfileData() {
        var dbRef: DatabaseReference!
        dbRef = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        
        dbRef.child("users/" + userID!).observe(.value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.nameTextField.text = value?["name"] as? String ?? ""
            self.cityTextField.text = value?["city"] as? String ?? ""
            self.webTextField.text = value?["web"] as? String ?? ""
            self.bioTextView.text = value?["bio"] as? String ?? ""
            
            let imgRef = Storage.storage().reference().child("images/" + userID! + ".jpg")
            
            imgRef.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
                if error != nil {
                    print(error)
                }
                else {
                    let image = UIImage(data: data!)
                    self.profileImageView.image = image
                }
            }
        }
    }
    
}

extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func pickPhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            print(info)
            return
        }
        profileImageView.image = image
        self.dismiss(animated: true, completion: nil)
        imageUpload()
    }
    
    private func imageUpload() {
        let userId = Auth.auth().currentUser?.uid
        
        let imageData = profileImageView.image?.jpegData(compressionQuality: 0.4)
        let storageRef = Storage.storage().reference().child("images/" + userId! + ".jpg")
        if let uploadData = imageData {
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if error != nil {
                    print(error!)
                }
            }
        }
    }
}
