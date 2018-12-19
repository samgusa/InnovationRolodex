//
//  LogInViewController.swift
//  InnovationRolodex
//
//  Created by Sam Greenhill on 8/12/18.
//  Copyright © 2018 simplyAmazingMachines. All rights reserved.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {

    
    @IBOutlet weak var emailTxt: UITextField!
    
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboard()
    }

    func logIn() {
        Auth.auth().signIn(withEmail: self.emailTxt.text!, password: self.passwordTxt.text!) { (user, error) in
            if error == nil {
                print("You have successfully Logged In")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Main")
                self.present(vc!, animated: true, completion: nil)
                
            } else {
                print("Error")
                
            }
        }
    }
    
    
    @IBAction func logInPressed(_ sender: Any) {
        if emailTxt.text == "" || passwordTxt.text == "" {
            emailTxt.placeholder = "Please Enter Email"
            passwordTxt.placeholder = "Please Enter Password"
            return
        } else {
            logIn()
        }
    }
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

