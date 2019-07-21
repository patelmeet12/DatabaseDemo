//
//  EditVC.swift
//  DataBase
//
//  Created by Admin on 10/07/19.
//  Copyright © 2019 360techno. All rights reserved.
//

import UIKit
import SQLite3

class EditVC: UIViewController {
    
    //MARK:-Outlets
    //TextField
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    
    var StoreID = String()
    
    //MARK:-LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        StoreID = UserDefaults.standard.object(forKey: "IDS") as! String
       
    }
    
    //MARK:-BtNAction
    @IBAction func Updatebtn(_ sender: UIButton) {
        
        let Update = "UPDATE Register SET Name = '\(txtName.text!)', Email = '\(txtEmail.text!)', Password = '\(txtPassword.text!)', Phone = '\(txtPhone.text!)' WHERE Id ='\(StoreID)' "
        
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(Database.Constant.db, Update, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Successfully updated row.")
            } else {
                print("Could not update row.")
            }
        } else {
            print("Error")
        }
        sqlite3_finalize(statement)
        
    }
    
}
