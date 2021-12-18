
import UIKit

class Manage_NoticeBoard: UIViewController {

  
    private let toolbar:UIToolbar = {
        let tool = UIToolbar()
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:#selector(addstudent))
        
        tool.items=[space,add]
        return tool
    }()
    
    @objc func addstudent()
    {
        let nav = Add_Notice()
        navigationController?.pushViewController(nav, animated: true)
        // present(nav,animated: true)
        
    }
    private let MyNoticeTable = UITableView()
    
    private var MyNoticeArray = [Notice]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MyNoticeArray = SQLiteHandler2.shared.fetch()
        MyNoticeTable.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(toolbar)
        view.addSubview(MyNoticeTable)
        view.backgroundColor = .white
        MyNoticeTable.dataSource = self
        MyNoticeTable.delegate = self
        MyNoticeTable.register(UITableViewCell.self, forCellReuseIdentifier: "noticecell")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let toolbarheight:CGFloat=view.safeAreaInsets.top + 40.0
        toolbar.frame = CGRect(x : 0,y : 30,width : view.frame.size.width ,height : toolbarheight )
        MyNoticeTable.frame = CGRect(x : 0,y: view.safeAreaInsets.top+50,width: view.frame.size.width,height: view.frame.size.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
        
    }
    

}

extension Manage_NoticeBoard: UITableViewDataSource , UITableViewDelegate
{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyNoticeArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "noticecell",for: indexPath)
        let nt = MyNoticeArray[indexPath.row]
        cell.textLabel?.text = "\(nt.id) \t | \t \(nt.nTitle) \t"
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return "NOTICE BOARD"
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let vc = Add_Notice()
        vc.notice = MyNoticeArray[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let id = MyNoticeArray[indexPath.row].id
        
        SQLiteHandler2.shared.delete(for: id) { success in
            
            if success {
                self.MyNoticeArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            } else {
                print("Unable to Delete from View Controller.")
            }
        }
    }
}
