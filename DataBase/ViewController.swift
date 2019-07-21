//
//  ViewController.swift
//  DataBase
//
//  Created by Admin on 25/06/19.
//  Copyright © 2019 360techno. All rights reserved.
//

import UIKit
import SQLite3

class ViewController: UIViewController {
    
    //MARK:-Outlets
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    
    //MARK:-LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK:- Create DataBase
        
        let Url = try!
            FileManager.default.url(for:.documentDirectory , in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("Register.sqlite")
        
        //MARK:-OpenDataBase
        
        if sqlite3_open(Url.path , &Database.Constant.db)  != SQLITE_OK{
            print("Error Opening DataBase")
        }
        else {
            print("Sucsessfully DataBase Created")
            print(Url)
        }
        
        //MARK:- Create Table
        
        if sqlite3_exec(Database.Constant.db,"CREATE TABLE IF NOT EXISTS Register(id INTEGER PRIMARY KEY AUTOINCREMENT, Name TEXT, Email TEXT, Password TEXT, Phone TEXT)", nil, nil, nil)  != SQLITE_OK
        {
            print("Error Creating Table")
        }
        else{
            print("Table Is Created")
        }

    }
    //MARK:-BtNAction
    @IBAction func Registerbtn(_ sender: UIButton) {
        if txtName.text == "" || txtEmail.text == "" || txtPassword.text == "" || txtPhone.text == "" {
            print("Your TextField Is Empty")
        }else{
            
            //MARK:- Insert DataBase
            
            var statement: OpaquePointer?
            
            let Insert = "insert into Register(Name,Email,Password,Phone) values('\(txtName.text!)','\(txtEmail.text!)','\(txtPassword.text!)','\(txtPhone.text!)')"
            print(Insert)
            if sqlite3_prepare_v2(Database.Constant.db, Insert, -1, &statement, nil) == SQLITE_OK {
                if sqlite3_step(statement) == SQLITE_DONE {
                    print("Successfully Inserted Value.")
                } else {
                    print("Could't Insert Value.")
                }
            }
        }
    }
    //MARK:-BtNAction
    @IBAction func Loginbtn(_ sender: Any) {
        
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as!
        LoginVC
        self.navigationController?.pushViewController(obj, animated: true)
        
        
    }
    
}
