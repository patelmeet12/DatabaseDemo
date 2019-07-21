//
//  DetailVC.swift
//  DataBase
//
//  Created by Admin on 10/07/19.
//  Copyright © 2019 360techno. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    //MARK:-Outlets
    //TextFields
    @IBOutlet weak var LBName: UILabel!
    @IBOutlet weak var LBEmail: UILabel!
    @IBOutlet weak var LBPassword: UILabel!
    @IBOutlet weak var LBPhone: UILabel!
    
    //MARK:-Decleration
    var StrName = String()
    var StrEmail = String()
    var StrPassword = String()
    var StrPhone = String()
    
    //MARK:-LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LBName.text = StrName
        LBEmail.text = StrEmail
        LBPassword.text = StrPassword
        LBPhone.text = StrPhone
    }
    
    //MARK:-BtNAction
    @IBAction func Editbtn(_ sender: Any) {
        
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "EditVC") as! EditVC
        self.navigationController?.pushViewController(obj, animated: true)
        
    }
    
    
}
