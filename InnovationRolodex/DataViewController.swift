//
//  DataViewController.swift
//  InnovationRolodex
//
//  Created by Sam Greenhill on 7/29/18.
//  Copyright © 2018 simplyAmazingMachines. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import FirebaseAuth
import Firebase

class DataViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var nameTxt: UITextField!
    
    @IBOutlet weak var emailTxt: UITextField!
    
    var user = Auth.auth().currentUser?.email
    
    @IBOutlet weak var phoneTxt: UITextField!
   
    
    @IBOutlet weak var saveButton: UIButton!
    
    
    @IBOutlet weak var memberSwitch: UISwitch!
    
    var switchData = Bool()
    
    @IBOutlet weak var specialtyImage: UIImageView!
    
    @IBOutlet weak var programBtn: UIButton!
    var buttonPressed = ""
    
    @IBOutlet weak var engineerBtn: UIButton!
    
    @IBOutlet weak var otherBtn: UIButton!
    
    @IBOutlet weak var notesTxt: UITextView!
    
    var programImage = UIImage(named: "computer")
    var engineerImage = UIImage(named: "wrench")
    var otherImage = UIImage(named: "other")
    
    var memberId: Int?
    var memberURL = URL(string: "http://localhost:8080/api/space")!
    
    var memberNameURL: String {
        if let memberId = memberId {
            return "http://localhost:8080/api/space/" + "\(memberId)"
        }
        return self.memberNameURL
    }
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(self.memberNameURL)
//        notesTxt.layer.borderWidth = 1
//        notesTxt.layer.borderColor = UIColor.blue.cgColor
        makeBorder(txtField: nameTxt, txtView: notesTxt)
        makeBorder(txtField: phoneTxt, txtView: nil)
        makeBorder(txtField: emailTxt, txtView: nil)
        specialtyImage.layer.borderWidth = 1
        specialtyImage.layer.borderColor = UIColor.blue.cgColor

        
        
        
        notesTxt.delegate = self
        
        //will need a function dismissKeyboard
        memberSwitch.addTarget(self, action: #selector(DataViewController.switchIsChanged(mySwitch:)), for: UIControlEvents.valueChanged)

        self.hideKeyboard()
        
//        if (userID == nameTxt.text) {
//            self.saveButton.isHidden = false
//        } else {
//            self.saveButton.isHidden = true
//        }
        
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameAlamo()

    }
    
    func nameAlamo() {
        Alamofire.request(memberNameURL).responseJSON { (response) -> Void in
            if ((response.result.value) != nil) {
                let json = JSON(response.result.value!)
                let names = json["name"].stringValue
                let email = json["email"].stringValue
                let member = json["member"].bool
                let specialty = json["specialty"].stringValue
                //self.specialtyImage.image = UIImage(named: specialty)
                if specialty == "computer" {
                    self.specialtyImage.image = self.programImage
                    self.btnAction(btn1: self.programBtn, btn2: self.engineerBtn, btn3: self.otherBtn)
                } else if specialty == "wrench" {
                    self.specialtyImage.image = self.engineerImage
                    self.btnAction(btn1: self.engineerBtn, btn2: self.programBtn, btn3: self.otherBtn)
                } else if specialty == "other" {
                    self.specialtyImage.image = self.otherImage
                    self.btnAction(btn1: self.otherBtn, btn2: self.programBtn, btn3: self.otherBtn)
                }
                let phone = json["phone"].stringValue
                let notes = json["notes"].stringValue
                
                let members = Member(name: names, email: email, member: member!, specialty: specialty, phone: phone, notes: notes)
                self.nameTxt.text = members.name
                self.emailTxt.text = members.email
                self.phoneTxt.text = members.phone
                self.notesTxt.text = members.notes
                self.buttonPressed = members.specialty
                if members.member == true {
                    self.memberSwitch.isOn = true
                    self.switchData = true
                } else if members.member == false {
                    self.memberSwitch.isOn = false
                    self.switchData = false
                }
                
                if let users = self.user {
                    if users == members.email {
                        print("It Worked")
                    } else {
                        self.saveButton.setTitle("Hello", for: .normal)
                        self.saveButton.isUserInteractionEnabled = false
                        self.nameTxt.isUserInteractionEnabled = false
                        self.emailTxt.isUserInteractionEnabled = false
                        self.phoneTxt.isUserInteractionEnabled = false
                        self.notesTxt.isUserInteractionEnabled = false
                        self.memberSwitch.isUserInteractionEnabled = false
                        self.programBtn.isUserInteractionEnabled = false
                        self.engineerBtn.isUserInteractionEnabled = false
                        self.otherBtn.isUserInteractionEnabled = false
                    }
                }
                
            } else {
                self.navigationItem.title = "There Was an Error"
                self.nameTxt.text = "Error"
                self.emailTxt.text = "Error"
                self.phoneTxt.text = "Error"
                self.notesTxt.text = "A Real Error"
                
            }
        }
    }
    
    
    func btnAction(btn1: UIButton, btn2: UIButton, btn3: UIButton) {
        btn1.isUserInteractionEnabled = false
        btn1.backgroundColor = UIColor.blue
        btn1.tintColor = UIColor.white
        
        btn2.isUserInteractionEnabled = true
        btn2.backgroundColor = UIColor.clear
        btn2.tintColor = UIColor.black
        
        btn3.isUserInteractionEnabled = true
        btn3.backgroundColor = UIColor.clear
        btn3.tintColor = UIColor.black
    }
    
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let myTextViewString = notesTxt.text
        if range.length > 140 {
            return false
        }
        let newLength = (myTextViewString?.characters.count)! + range.length
        
        return newLength < 140
    }
    



    func tryData(stringBtn: String) {
        if stringBtn == "computer" {
            self.programBtn.backgroundColor = UIColor.blue
            self.programBtn.tintColor = UIColor.white
            
        } else if stringBtn == "wrench" {
            self.engineerBtn.backgroundColor = UIColor.blue
            self.engineerBtn.tintColor = UIColor.white
            
        } else if stringBtn == "other" {
            self.otherBtn.backgroundColor = UIColor.blue
            self.otherBtn.tintColor = UIColor.white
            
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
            btnAction(btn1: self.programBtn, btn2: self.engineerBtn, btn3: self.otherBtn)
            specialtyImage.image = programImage
            print("\(buttonPressed)")
            print("Bool: \(self.switchData)")
        }
    }
    
    
    @IBAction func engineerBtnPressed(_ sender: Any) {
        if buttonPressed != "wrench" {
            buttonPressed = "wrench"
            btnAction(btn1: self.engineerBtn, btn2: self.programBtn, btn3: self.otherBtn)
            specialtyImage.image = engineerImage
            print("\(buttonPressed)")
            print("Bool: \(self.switchData)")
        }
    }
    
    
    @IBAction func otherBtnPressed(_ sender: Any) {
        if buttonPressed != "other" {
            buttonPressed = "other"
            btnAction(btn1: self.otherBtn, btn2: self.programBtn, btn3: self.engineerBtn)
            specialtyImage.image = otherImage
            print("\(buttonPressed)")
            print("Bool: \(self.switchData)")
        }
    }
    
    
    
    func makeBorder(txtField: UITextField?, txtView: UITextView?) {
        txtField?.layer.borderWidth = 1
        txtField?.layer.borderColor = UIColor.blue.cgColor
        txtView?.layer.borderWidth = 1
        txtView?.layer.borderColor = UIColor.blue.cgColor
    }
    
    
    @IBAction func saveBtn(_ sender: Any) {
        if nameTxt.text == "" || emailTxt.text == "" || phoneTxt.text == "" || buttonPressed == "" {
            nameTxt.placeholder = "Please Enter Name"
            emailTxt.placeholder = "Please finish the rest of the info"
            phoneTxt.placeholder = "Please Enter the Correct Info"
            return
        } else {
            
            let member = Member(id: self.memberId, name: self.nameTxt.text!, email: self.emailTxt.text!, member: self.switchData, specialty: self.buttonPressed, phone: self.phoneTxt.text!, notes: self.notesTxt.text!)
            

            let urlMember = URL(string: self.memberNameURL)!
            var request = URLRequest(url: self.memberURL)
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
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
  
    
    

}

extension UIViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DataViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


