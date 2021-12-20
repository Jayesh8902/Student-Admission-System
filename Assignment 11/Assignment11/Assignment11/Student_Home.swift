
import UIKit

class Student_Home: UIViewController {
    private let btnprofile:UIButton={
        let btn1 = UIButton()
        btn1.setTitle("My Profile", for: .normal)
        btn1.backgroundColor = .red
        btn1.layer.cornerRadius = 10
        btn1.addTarget(self, action: #selector(GoToProf), for: .touchUpInside)
        return btn1
    }()
    
    @objc public func GoToProf()
    {
        let nav = Student_Profile()
        navigationController?.pushViewController(nav, animated: true)
        print("SPID" + UserDefaults.standard.string(forKey: "uname")!)
    }
    
    private let btnnotice:UIButton={
        let btn1 = UIButton()
        btn1.setTitle("Read Notice Board", for: .normal)
        btn1.backgroundColor = .blue
        btn1.layer.cornerRadius = 10
        btn1.addTarget(self, action: #selector(GoToNotice), for: .touchUpInside)
        return btn1
        
    }()
    
    @objc public func GoToNotice()
    {
        let vc = List_Notice()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(btnprofile)
        view.addSubview(btnnotice)
       
       
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnprofile.frame = CGRect(x: 20, y: 200, width: view.frame.size.width-40, height: 40)
        btnnotice.frame = CGRect(x: 20, y: 250, width: view.frame.size.width-40, height: 40)
       // btnfind.frame = CGRect(x: 20, y: 300, width: view.frame.size.width-40, height: 40)
        
    }

}
