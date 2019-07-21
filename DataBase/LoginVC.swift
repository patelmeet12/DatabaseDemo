//
//  LoginVC.swift
//  DataBase
//
//  Created by Admin on 10/07/19.
//  Copyright © 2019 360techno. All rights reserved.
//

import UIKit
import SQLite3

class LoginVC: UIViewController {
    
    //MARK:-Outlets
    // TextField
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    //MARK:-LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    //MARK:-BtNAction
    @IBAction func Loginbtn(_ sender: UIButton) {
        
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "ListVC") as! ListVC
        
        var statment: OpaquePointer?
        
        let LogIN = "SELECT * from Register where Name = '\(txtName.text!)' AND Password = '\(txtPassword.text!)'"
        
        if sqlite3_prepare_v2(Database.Constant.db, LogIN, -1, &statment, nil) == SQLITE_OK {
            
            if sqlite3_step(statment) == SQLITE_ROW {
                
                print("Login Suceesfull")
            } else {
                print("Plese enter Valide Name and Password")
            }
        }
        
        sqlite3_finalize(statment)
        
        self.navigationController?.pushViewController(obj, animated: true)
        
        
    }
    

}
