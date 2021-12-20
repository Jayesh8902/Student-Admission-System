

import UIKit

class Change_Password: UIViewController {

    private let lbltitle : UILabel = {
        let lbl = UILabel()
        lbl.text = """
        Change Password
        """
        lbl.font = UIFont(name:"ArialRoundedMTBold", size: 30.0)
        
        lbl.layer.cornerRadius = 100
        lbl.numberOfLines = 2
        
        return lbl
    }()
    
    private let lblpass : UILabel = {
        let lbl = UILabel()
        lbl.text = "Enter New Password"
        lbl.font = UIFont(name:"ArialRoundedMTBold", size: 18.0)
        //        lbl.textColor = .white
        return lbl
    }()
    
    
    private let txtpassword : UITextField = {
        let txt = UITextField()
        txt.placeholder = ""
        txt.borderStyle = UITextField.BorderStyle.roundedRect
        txt.textAlignment = .center
        txt.layer.cornerRadius = 30
        return txt
    }()
    
    
    private let lblcpass : UILabel = {
        let lbl = UILabel()
        lbl.text = "Enter Confirm Password"
        lbl.font = UIFont(name:"ArialRoundedMTBold", size: 18.0)
        //        lbl.textColor = .white
        return lbl
    }()
    
    private let txtcpass : UITextField = {
        let txt = UITextField()
        txt.placeholder = ""
        txt.borderStyle = UITextField.BorderStyle.roundedRect
        txt.textAlignment = .center
        txt.layer.cornerRadius = 30
        return txt
    }()
    
    private let btnchange:UIButton={
        let btn1 = UIButton()
        btn1.setTitle("CHANGE PASSWORD", for: .normal)
        btn1.backgroundColor = #colorLiteral(red: 0.4392156899, green:
            0.01176470611, blue: 0.1921568662, alpha: 1)
        btn1.layer.cornerRadius = 10
        btn1.addTarget(self, action: #selector(navigate), for: .touchUpInside)
        return btn1
    }()
    
    @objc private func navigate()
    {
        var spid : Int  = Int(UserDefaults.standard.string(forKey: "uname")!) ?? 0
        var pass : String = txtpassword.text!
        SQLiteHandler.shared.updatepass(for: spid, for: pass) { (sucess) in
            if sucess
            {
                print("password Updated")
            }
            else
            {
                print("Fail")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(lbltitle)
        view.addSubview(lblpass)
        view.addSubview(txtpassword)
        view.addSubview(txtpassword)
        view.addSubview(lblcpass)
        view.addSubview(txtcpass)
          view.addSubview(btnchange)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        lbltitle.frame = CGRect(x: 55, y: 100, width: view.frame.size.width-150, height: 100)
        lblpass.frame = CGRect(x: 55, y: 200, width: view.frame.size.width-60, height: 30)
        txtpassword.frame = CGRect(x: 55, y: 240, width: view.frame.size.width-100, height: 40)
        lblcpass.frame = CGRect(x: 55, y: 285, width: view.frame.size.width-60, height: 30)
        txtcpass.frame = CGRect(x: 55, y: 320, width: view.frame.size.width-100, height: 40)
        btnchange.frame = CGRect(x: 55, y: 375, width: view.frame.size.width-100, height: 40)
    }
    
}
