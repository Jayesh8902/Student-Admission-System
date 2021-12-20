//
//  Student_Profile.swift
//  Assignment11
//
//  Created by DCS on 20/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class Student_Profile: UIViewController {
   
    var stud = [Student]()
   
    private let lblspid : UILabel = {
        let lbl = UILabel()
        lbl.text = "SPID"
        return lbl
    }()
    private let lblspidvalue : UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        return lbl
    }()
    
    private let lblname : UILabel = {
        let lbl = UILabel()
        lbl.text = "Student Name"
        return lbl
    }()
    private let lblnamevalue : UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        return lbl
    }()
    
    private let lblgender : UILabel = {
        let lbl = UILabel()
        lbl.text = "GENDER"
        return lbl
    }()
    private let lblgendervalue : UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        return lbl
    }()
    
    private let lblclass : UILabel = {
        let lbl = UILabel()
        lbl.text = "CLASS"
        return lbl
    }()
    private let lblclassvalue : UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        return lbl
    }()
    
    private let lbldob : UILabel = {
        let lbl = UILabel()
        lbl.text = "Date Of Birth"
        return lbl
    }()
    private let lbldobvalue : UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        return lbl
    }()
//    name,dob,gender,class
    
    private let btnpassword:UIButton={
        let btn1 = UIButton()
        btn1.setTitle("Change Password", for: .normal)
        btn1.backgroundColor = #colorLiteral(red: 0.4392156899, green:
            0.01176470611, blue: 0.1921568662, alpha: 1)
        btn1.layer.cornerRadius = 10
       btn1.addTarget(self, action: #selector(navigate), for: .touchUpInside)
        return btn1
    }()
    
    @objc public func navigate()
    {
        let nav = Change_Password()
        navigationController?.pushViewController(nav, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var spid : Int  = Int(UserDefaults.standard.string(forKey: "uname")!) ?? 0
        
//        let sid = Int(spid)
        //var s = [Student]()
         stud = SQLiteHandler.shared.fetchprof(for: spid)
        
        lblspidvalue.text = String(stud[0].spid)
        lblnamevalue.text = stud[0].name
        lbldobvalue.text = stud[0].dob
        lblgendervalue.text = stud[0].gender
        lblclassvalue.text = stud[0].classname

    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(lblspid)
        view.addSubview(lblspidvalue)
        
        view.addSubview(lblname)
        view.addSubview(lblnamevalue)
        
        view.addSubview(lbldob)
        view.addSubview(lbldobvalue)
        
        view.addSubview(lblgender)
        view.addSubview(lblgendervalue)
        
        view.addSubview(lblclass)
        view.addSubview(lblclassvalue)
        
        view.addSubview(btnpassword)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        lblspid.frame = CGRect(x: 20, y: 80, width: view.frame.size.width-40, height: 30)
        lblspidvalue.frame = CGRect(x: 20, y: 110, width: view.frame.size.width-40, height: 30)
        
        lblname.frame = CGRect(x: 20, y: 150, width: view.frame.size.width-40, height: 30)
        lblnamevalue.frame = CGRect(x: 20, y: 180, width: view.frame.size.width-40, height: 30)
        
        lbldob.frame = CGRect(x: 20, y: 230, width: view.frame.size.width-40, height: 30)
        lbldobvalue.frame = CGRect(x: 20, y: 260, width: view.frame.size.width-40, height: 30)
        
        lblgender.frame = CGRect(x: 20, y: 310, width: view.frame.size.width-40, height: 30)
        lblgendervalue.frame = CGRect(x: 20, y: 340, width: view.frame.size.width-40, height: 30)
        
        lblclass.frame = CGRect(x: 20, y: 380, width: view.frame.size.width-40, height: 30)
        lblclassvalue.frame = CGRect(x: 20, y: 410, width: view.frame.size.width-40, height: 30)
        
        
        btnpassword.frame = CGRect(x: 20, y: 480, width: view.frame.size.width-40, height: 40)
    }
   
}
