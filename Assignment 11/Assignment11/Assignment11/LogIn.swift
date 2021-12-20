
import UIKit

class LogIn: UIViewController {

    var temp = SQLiteHandler.shared
    
    private let lbltitle : UILabel = {
        let lbl = UILabel()
        lbl.text = """
                   Student
                   Management
                   """
        lbl.font = UIFont(name:"ArialRoundedMTBold", size: 30.0)

        lbl.layer.cornerRadius = 100
        lbl.numberOfLines = 2
        
        return lbl
    }()
    
    private let lbluname : UILabel = {
        let lbl = UILabel()
        lbl.text = "Enter Username"
        lbl.font = UIFont(name:"ArialRoundedMTBold", size: 18.0)
//        lbl.textColor = .white
        return lbl
    }()
    
    
    private let txtuname : UITextField = {
        let txt = UITextField()
        txt.placeholder = "@example.com"
        txt.borderStyle = UITextField.BorderStyle.roundedRect
        txt.textAlignment = .center
        txt.layer.cornerRadius = 30
        return txt
    }()
    
    
    private let lblpass : UILabel = {
        let lbl = UILabel()
        lbl.text = "Enter Password"
        lbl.font = UIFont(name:"ArialRoundedMTBold", size: 18.0)
//        lbl.textColor = .white
        return lbl
    }()
    
    private let txtpass : UITextField = {
        let txt = UITextField()
        txt.placeholder = ""
        txt.borderStyle = UITextField.BorderStyle.roundedRect
        txt.textAlignment = .center
        txt.layer.cornerRadius = 30
        return txt
    }()
    
    private let lblmsg : UILabel = {
        let lbl = UILabel()
        lbl.text = "Login With SPID and PASSWORD"
        lbl.textColor = .red
        lbl.font = UIFont(name:"ArialRoundedMTBold", size: 18.0)
        //        lbl.textColor = .white
        return lbl
    }()
    
    private let btnlogin:UIButton={
        let btn1 = UIButton()
        btn1.setTitle("Login", for: .normal)
        btn1.backgroundColor = #colorLiteral(red: 0.4392156899, green:
            0.01176470611, blue: 0.1921568662, alpha: 1)
        btn1.layer.cornerRadius = 10
        btn1.addTarget(self, action: #selector(navigate), for: .touchUpInside)
        return btn1
    }()
    
    @objc private func navigate()
    {
        if txtuname.text == "Admin" && txtpass.text == "Admin"
        {
            print("clicked")
            let nav = AdminHome()
            navigationController?.pushViewController(nav, animated: true)
        }
        else
        {
            let uname = Int(txtuname.text!)
            let upass = txtpass.text!
            let temp = SQLiteHandler.shared.LoginCheck(for: uname!, for: upass)
            //print("\(uname) \t\t \(upass)")
            if temp == 1
            {
                UserDefaults.standard.setValue(uname, forKey: "uname")
                let nav = Student_Home()
                navigationController?.pushViewController(nav, animated: true)
            }
            else
            {
                lblmsg.text = "Username Or Password Is Wrong !"
            }
        }
        
        //present(nav,animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignbackground()
        view.addSubview(lbluname)
        view.addSubview(txtuname)
        view.addSubview(lblpass)
        view.addSubview(txtpass)
        view.addSubview(btnlogin)
        view.addSubview(lbltitle)
        view.addSubview(lblmsg)
       
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        lbltitle.frame = CGRect(x: 55, y: 100, width: view.frame.size.width-150, height: 100)
        lbluname.frame = CGRect(x: 55, y: 200, width: view.frame.size.width-60, height: 30)
        txtuname.frame = CGRect(x: 55, y: 240, width: view.frame.size.width-100, height: 40)
        lblpass.frame = CGRect(x: 55, y: 285, width: view.frame.size.width-60, height: 30)
        txtpass.frame = CGRect(x: 55, y: 320, width: view.frame.size.width-100, height: 40)
        btnlogin.frame = CGRect(x: 55, y: 375, width: view.frame.size.width-100, height: 40)
        lblmsg.frame = CGRect(x: 50, y: 420, width: view.frame.size.width, height: 40)
    }
    
    func assignbackground(){
        let background = UIImage(named: "Loginbg2")
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }}
