

import UIKit

class List_Notice: UIViewController {

    private let MyNoticeTable = UITableView()
    
    private var MyNoticeArray = [Notice]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MyNoticeArray = SQLiteHandler2.shared.fetch()
        MyNoticeTable.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        view.addSubview(MyNoticeTable)
        view.backgroundColor = .white
        MyNoticeTable.dataSource = self
        MyNoticeTable.delegate = self
        MyNoticeTable.register(UITableViewCell.self, forCellReuseIdentifier: "noticecell")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        MyNoticeTable.frame = CGRect(x : 0,y: view.safeAreaInsets.top,width: view.frame.size.width,height: view.frame.size.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
        
    }
    

}
extension List_Notice: UITableViewDataSource , UITableViewDelegate
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
        let vc = View_Notice()
        vc.notice = MyNoticeArray[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
