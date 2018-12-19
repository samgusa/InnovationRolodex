//
//  SignUpViewController.swift
//  InnovationRolodex
//
//  Created by Sam Greenhill on 8/7/18.
//  Copyright © 2018 simplyAmazingMachines. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import Alamofire
import SwiftyJSON

class SignUpViewController: UIViewController {

    
    
    @IBOutlet weak var nameTxt: UITextField!
    
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var phoneTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var notesTxt: UITextView!
    
    @IBOutlet weak var memberSwitch: UISwitch!
    
    var switchData = false
    
    @IBOutlet weak var programBtn: UIButton!
    var buttonPressed = ""
    
    @IBOutlet weak var engineerBtn: UIButton!
    
    @IBOutlet weak var otherBtn: UIButton!
 
    //member information:
    
    var member = URL(string: "http://localhost:8080/api/space")!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        notesTxt.layer.borderWidth = 1
//        notesTxt.layer.borderColor = UIColor.blue.cgColor
        makeBorder(txtField: nameTxt, txtView: notesTxt)
        makeBorder(txtField: phoneTxt, txtView: nil)
        makeBorder(txtField: emailTxt, txtView: nil)
        makeBorder(txtField: passwordTxt, txtView: nil)
        
        
        
        memberSwitch.addTarget(self, action: #selector(SignUpViewController.switchIsChanged(mySwitch:)), for: UIControlEvents.valueChanged)
        

       
        self.hideKeyboard()
    }
    
    func makeBorder(txtField: UITextField?, txtView: UITextView?) {
        txtField?.layer.borderWidth = 1
        txtField?.layer.borderColor = UIColor.blue.cgColor
        txtView?.layer.borderWidth = 1
        txtView?.layer.borderColor = UIColor.blue.cgColor
    }
    
    
    
    
    func signIn() {
        if self.emailTxt.text == "" || self.passwordTxt.text == "" {
            self.emailTxt.placeholder = "Please Enter Some Text"
            self.passwordTxt.placeholder = "Please Enter Some Text"
        } else {
            Auth.auth().createUser(withEmail: emailTxt.text!, password: passwordTxt.text!, completion: { (user, error) in
                if error == nil {
                    print("You have successfully signed up")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Main")
                    
                    let member = Member(name: "\(self.nameTxt.text!)", email: "\(self.emailTxt.text!)", member: self.switchData, specialty: "\(self.buttonPressed)", phone: "\(self.phoneTxt.text!)", notes: "\(self.notesTxt.text!)")
                    
                    var request = URLRequest(url: self.member)
                    request.httpMethod = "POST"
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    
                    
                    
                    if let data = try? JSONEncoder().encode(member) {
                        request.httpBody = data
                    }
                    
                    URLSession.shared.dataTask(with: request) { data, response, error in
                        
                        if let error = error {
                            print(error.localizedDescription)
                            return
                        }  
                    }.resume()
                    
                    
                    self.present(vc!, animated: true, completion: nil)
                } else {
                    print(error)
                }
            })
            
            

            
        }
    }
    
    
    
    

    @objc func switchIsChanged(mySwitch: UISwitch) {
        if mySwitch.isOn {
            self.switchData = true
            print("\(switchData)")
        } else {
            self.switchData = false
            print("\(switchData)")
        }
    }
    
    
    
    @IBAction func programBtnPressed(_ sender: Any) {
        if buttonPressed != "computer" {
            buttonPressed = "computer"
            programBtn.backgroundColor = UIColor.blue
            programBtn.tintColor = UIColor.white
            engineerBtn.backgroundColor = UIColor.clear
            engineerBtn.tintColor = UIColor.black
            otherBtn.backgroundColor = UIColor.clear
            otherBtn.tintColor = UIColor.black
            print("\(buttonPressed)")
        }
    }
    
    @IBAction func EngineerBtnPressed(_ sender: Any) {
        
        if buttonPressed != "wrench" {
            buttonPressed = "wrench"
            programBtn.backgroundColor = UIColor.clear
            programBtn.tintColor = UIColor.black
            engineerBtn.backgroundColor = UIColor.blue
            engineerBtn.tintColor = UIColor.white
            otherBtn.backgroundColor = UIColor.clear
            otherBtn.tintColor = UIColor.black
            
            
            print("\(buttonPressed)")
        }
    }
    
    
    @IBAction func otherBtnPressed(_ sender: Any) {
        if buttonPressed != "other" {
            buttonPressed = "other"
            programBtn.backgroundColor = UIColor.clear
            programBtn.tintColor = UIColor.black
            engineerBtn.backgroundColor = UIColor.clear
            engineerBtn.tintColor = UIColor.black
            otherBtn.backgroundColor = UIColor.blue
            otherBtn.tintColor = UIColor.white
            print("\(buttonPressed)")
        }
        
    }
    
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        if nameTxt.text == "" || emailTxt.text == "" || phoneTxt.text == "" || buttonPressed == "" {
            nameTxt.placeholder = "Please Enter Name"
            emailTxt.placeholder = "Please finish the rest of the info"
            phoneTxt.placeholder = "Please Enter the Correct Info"
            return
        } else {
            signIn()
        }
    }
    
    
    
    
    
}

extension UIViewController {
    func hidingKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc func dismissingKeyboard() {
        view.endEditing(true)
    }
}













