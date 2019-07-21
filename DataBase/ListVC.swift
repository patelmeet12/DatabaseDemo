//
//  DetailVC.swift
//  DataBase
//
//  Created by Admin on 10/07/19.
//  Copyright © 2019 360techno. All rights reserved.
//

import UIKit
import SQLite3

class ListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK:-Outlets
    //TableView
    @IBOutlet weak var TableViewOut: UITableView!
    
    //MARK:-Decleration
    var ArrName = NSMutableArray()
    var data = NSMutableArray()
    
    var tableView: UITableView = UITableView()
    
    //MARK:-LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableViewOut.tableFooterView = UIView.init(frame: .zero)
        
        var statement: OpaquePointer?
        
        let selectName = "SELECT Name, Email, Password, Phone, id FROM Register"
        
        if sqlite3_prepare_v2(Database.Constant.db, selectName, -1, &statement, nil) == SQLITE_OK {
            
            while sqlite3_step(statement) == SQLITE_ROW {
                
                let NameStore = String(cString: sqlite3_column_text(statement, 0))
                ArrName.add(NameStore)
                
                let EmailStore = String(cString: sqlite3_column_text(statement, 1))
                
                let PasswordStore = String(cString: sqlite3_column_text(statement, 2))
                
                let PhoneStore = String(cString: sqlite3_column_text(statement, 3))
                
                let IDStore = String(cString: sqlite3_column_text(statement, 4))
                
                let dict = ["Name":NameStore, "Email":EmailStore, "Password":PasswordStore, "Phone":PhoneStore, "id":IDStore] as NSDictionary
                
                print(dict)
                data.add(dict)
                
                print("Select Success")
            }
        }
        else {
            print("Please Select Name")
        }
    }
    
    //MARK:-TableMethod
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArrName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableCell
        cell.TCell.text = ArrName[indexPath.row] as? String
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        
        if let MyArray = data.object(at: indexPath.row) as? NSDictionary {
            
            if let name = MyArray.object(forKey: "Name") as? String{
                obj.StrName = name
                print(ArrName)
            }
            
            if let email = MyArray.object(forKey: "Email") as? String {
                obj.StrEmail = email
                print(email)
            }
            
            if let password = MyArray.object(forKey: "Password") as? String {
                obj.StrPassword = password
                print(password)
            }
            
            if let phone = MyArray.object(forKey: "Phone") as? String {
                obj.StrPhone = phone
                print(phone)
            }
            
            if let ID = MyArray.object(forKey: "id") as? String {
                UserDefaults.standard.set(ID, forKey: "IDS")
            }
            
        }
        
        navigationController?.pushViewController(obj, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        
        if editingStyle == .delete {
            
            if let arrdata1 = data.object(at: indexPath.row) as? NSDictionary {
                
                let id = arrdata1.object(forKey: "id")
                
                let Delete = "DELETE FROM Register WHERE Id = '\(id!)'"
                
                var statement: OpaquePointer?
                
                if sqlite3_prepare_v2(Database.Constant.db, Delete, -1, &statement, nil) == SQLITE_OK {
                    if sqlite3_step(statement) == SQLITE_DONE {
                        print(Delete)
                        print("Successfully delete row.")
                    } else {
                        print("Could not delete row.")
                    }
                } else {
                    print("Error")
                }
                sqlite3_finalize(statement)
                
                ArrName.removeObject(at:indexPath.row)
                tableView.reloadData()
            }
        }
    }


}
