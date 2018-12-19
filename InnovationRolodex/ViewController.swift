//
//  ViewController.swift
//  InnovationRolodex
//
//  Created by Sam Greenhill on 7/28/18.
//  Copyright © 2018 simplyAmazingMachines. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import Alamofire
import SwiftyJSON
import Firebase


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    let memberURL = "http://localhost:8080/api/space"
    
    let user = Auth.auth().currentUser?.email
    
    
    var saveArr: [Member] = [Member]()
    var number = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.reloadData()
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        alamofire()
        self.saveArr.removeAll()
        self.tableView.reloadData()
        print("Count: \(saveArr.count)")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "viewSegue", sender: indexPath)
    }
    

    func alamofire() {
        Alamofire.request(memberURL).responseJSON { (response) -> Void in
            if ((response.result.value) != nil) {
                let json = JSON(response.result.value!) //convert the responseJSON to swiftyJSON
                let names = json[].arrayValue // get the results as an array
                for name in names {
                    let memberNames = name["name"].stringValue
                    let memberEmail = name["email"].stringValue
                    let memberMem = name["member"].bool
                    let memberSpec = name["specialty"].stringValue
                    let memberPhone = name["phone"].stringValue
                    let memberNotes = name["notes"].stringValue
                    var memberId = Int()
                    
                    if let membersIds = name["id"].int {
                        memberId = membersIds
                        print("ID: \(memberId)")
                    }
                    
                    
                    let dataMember = Member(id: memberId, name: memberNames, email: memberEmail, member: memberMem!, specialty: memberSpec, phone: memberPhone, notes: memberNotes)
                    
                    self.tableView.reloadData()
                    self.saveArr.append(dataMember)
                    print("DataMember: \(dataMember.member)")
                    
                    print("Number: \(self.number)")
                }
                DispatchQueue.main.async {
                    
                    self.tableView.reloadData()
                }
            }
        }
    }
    
 

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return saveArr.count
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainTableViewCell
        
        var memberData = saveArr[indexPath.row]
        cell.nameLbl.text = memberData.name
        cell.phoneLbl.text = memberData.phone
        cell.personImage.image = UIImage(named: memberData.specialty)
        if memberData.member == true {
            //cell.nameLbl.textColor = UIColor.blue
            cell.personImage.layer.borderWidth = 2
            cell.personImage.layer.borderColor = UIColor.blue.cgColor
        } else {
            cell.nameLbl.textColor = UIColor.black
            cell.personImage.layer.borderWidth = 0
        }
        
        return cell
    }
    
    

    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewSegue" {
            let nxtVC = segue.destination as? DataViewController
            let myIndexPath = self.tableView.indexPathForSelectedRow!
            let row = myIndexPath.row
            var memberData = saveArr[row]
            if memberData.id != 0 {
                nxtVC?.memberId = memberData.id
            } else {
                return
            }
        }
    }
    
    
    
    
    
    
    @IBAction func logOutPressed(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "First")
            self.present(vc!, animated: true, completion: nil)
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError)")
        }
        
        
    }
    

}

