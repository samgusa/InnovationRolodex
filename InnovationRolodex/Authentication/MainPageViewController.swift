//
//  MainPageViewController.swift
//  InnovationRolodex
//
//  Created by Sam Greenhill on 8/12/18.
//  Copyright © 2018 simplyAmazingMachines. All rights reserved.
//

import UIKit
import Firebase

class MainPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                self.performSegue(withIdentifier: "home", sender: nil)
            }
        }
    }


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
