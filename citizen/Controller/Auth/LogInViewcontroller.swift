//
//  LogInViewcontroller.swift
//  citizen
//
//  Created by Артем Жорницкий on 05/05/2019.
//  Copyright © 2019 Артем Жорницкий. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class LogInViewController : UIViewController, UITextFieldDelegate {
    @IBOutlet weak var loginTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var authButton: UIButton!
    
    @IBAction func authButtonTapped(_ sender: Any) {
        if let login = loginTextfield.text, let password = passwordTextfield.text {
            Auth.auth().signIn(withEmail: login, password: password) { (user, error) in
                
                if error != nil {
                    print(error!)
                }
                else {
                    self.performSegue(withIdentifier: "goLog", sender: Any?.self)
                    print("user logged in")
                }
            }
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.loginTextfield.delegate = self
        self.passwordTextfield.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginTextfield.resignFirstResponder()
        passwordTextfield.resignFirstResponder()
        return true
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= 35.0
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

