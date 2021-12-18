

import UIKit

class Find_Student: UIViewController {
    
    private let lblclass : UILabel = {
        let lbl = UILabel()
        lbl.text = "Enter Class Name"
        return lbl
    }()
    private let txtclass : UITextField = {
        let txt = UITextField()
        txt.placeholder = ""
        txt.borderStyle = UITextField.BorderStyle.roundedRect
        return txt
    }()
    
    private let btnfind:UIButton={
        let btn1 = UIButton()
        btn1.setTitle("FIND", for: .normal)
        btn1.backgroundColor = .red
        btn1.layer.cornerRadius = 10
        btn1.addTarget(self, action: #selector(se),for: .touchUpInside)
        return btn1
        
    }()
    
    @objc public func se()
    {
        print("click")
        let s = txtclass.text!
        MyStudentArray = SQLiteHandler.shared.fetchbyclass(for: s)
        MyStudentTable.reloadData()
    }
    
    private let MyStudentTable = UITableView()
    
    private var MyStudentArray = [Student]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        MyStudentArray = SQLiteHandler.shared.fetch()
       // MyStudentTable.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(lblclass)
        view.addSubview(txtclass)
        view.addSubview(btnfind)
        view.addSubview(MyStudentTable)
        MyStudentTable.dataSource = self
        MyStudentTable.delegate = self
        MyStudentTable.register(UITableViewCell.self, forCellReuseIdentifier: "StudentCell")

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        lblclass.frame = CGRect(x: 20, y: 70, width: view.frame.size.width-40, height: 30)
        txtclass.frame = CGRect(x: 20, y: 110, width: view.frame.size.width-40, height: 30)
         btnfind.frame = CGRect(x: 20, y: 160, width: view.frame.size.width-40, height: 30)
        MyStudentTable.frame = CGRect(x : 0,y: view.safeAreaInsets.top+150,width: view.frame.size.width,height: view.frame.size.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
        
    }
}
extension Find_Student: UITableViewDataSource , UITableViewDelegate
{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyStudentArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell",for: indexPath)
        let std = MyStudentArray[indexPath.row]
        cell.textLabel?.text = "\(std.id) \t | \t \(std.spid) \t | \t \(std.name) \t | \t \(std.classname)"
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = Add_Student()
        vc.stud = MyStudentArray[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return "Student Names"
    }
    
    
}
