//
//  ManageStudent.swift
//  Assignment11
//
//  Created by DCS on 14/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ManageStudent: UIViewController {
    
    //private var temp = SQLiteHandler.shared.fetch()
    
    private let toolbar:UIToolbar = {
        let tool = UIToolbar()
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:#selector(addstudent))
        
        tool.items=[space,add]
        return tool
    }()
    
    @objc func addstudent()
    {
        let nav = Add_Student()
        navigationController?.pushViewController(nav, animated: true)
       // present(nav,animated: true)
        
    }
    
    private let MyStudentTable = UITableView()
    
    private var MyStudentArray = [Student]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        MyStudentArray = SQLiteHandler.shared.fetch()
        MyStudentTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(toolbar)
        view.addSubview(MyStudentTable)
        view.backgroundColor = .white
        MyStudentTable.dataSource = self
        MyStudentTable.delegate = self
        MyStudentTable.register(UITableViewCell.self, forCellReuseIdentifier: "StudentCell")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let toolbarheight:CGFloat=view.safeAreaInsets.top + 40.0
        toolbar.frame = CGRect(x : 0,y : 30,width : view.frame.size.width ,height : toolbarheight )
        MyStudentTable.frame = CGRect(x : 0,y: view.safeAreaInsets.top+50,width: view.frame.size.width,height: view.frame.size.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
        
    }
 
}
extension ManageStudent: UITableViewDataSource , UITableViewDelegate
{

//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyStudentArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
    
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell",for: indexPath)
        let std = MyStudentArray[indexPath.row]
        cell.textLabel?.text = "\(std.id) \t | \t \(std.spid) \t | \t \(std.name)"
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let id = MyStudentArray[indexPath.row].id
        
        SQLiteHandler.shared.delete(for: id) { success in
            
            if success {
                self.MyStudentArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            } else {
                print("Unable to Delete from View Controller.")
            }
        }
    }
}
