

import UIKit

class AdminHome: UIViewController {
  
    
    private let btnstd:UIButton={
        let btn1 = UIButton()
        btn1.setTitle("Manage Student", for: .normal)
        btn1.backgroundColor = .red
        btn1.layer.cornerRadius = 10
        btn1.addTarget(self, action: #selector(GoToStd), for: .touchUpInside)
        return btn1
        
    }()
    
    private let btnnt:UIButton={
        let btn1 = UIButton()
        btn1.setTitle("Manage Notice Board", for: .normal)
        btn1.backgroundColor = .blue
        btn1.layer.cornerRadius = 10
        btn1.addTarget(self, action: #selector(GoToNotice), for: .touchUpInside)
        return btn1
        
    }()
    
    private let btnfind:UIButton={
        let btn1 = UIButton()
        btn1.setTitle("Find Student", for: .normal)
        btn1.backgroundColor = .red
        btn1.layer.cornerRadius = 10
        btn1.addTarget(self, action: #selector(GoToFind), for: .touchUpInside)
        return btn1
        
    }()
    
    
    @objc private func GoToFind()
    {
        let nav = Find_Student()
        navigationController?.pushViewController(nav, animated: true)
        // present(nav,animated: true)
    }
    
    @objc private func GoToStd()
    {
        let nav = ManageStudent()
        navigationController?.pushViewController(nav, animated: true)
       // present(nav,animated: true)
    }
    
    @objc private func GoToNotice()
   {
        let n = Manage_NoticeBoard()
        navigationController?.pushViewController(n, animated: true)
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(btnstd)
        view.addSubview(btnnt)
        view.addSubview(btnfind)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnstd.frame = CGRect(x: 20, y: 200, width: view.frame.size.width-40, height: 40)
        btnnt.frame = CGRect(x: 20, y: 250, width: view.frame.size.width-40, height: 40)
        btnfind.frame = CGRect(x: 20, y: 300, width: view.frame.size.width-40, height: 40)
       
    }
    

}
