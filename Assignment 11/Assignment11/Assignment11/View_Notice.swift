

import UIKit

class View_Notice: UIViewController {

     var notice:Notice?
    
    private let lblnoticetitlevalue : UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        return lbl
    }()
    
   
    private let lblnotice : UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.numberOfLines = 50
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(lblnoticetitlevalue)
        view.addSubview(lblnotice)
        
        if let nt = notice {
            lblnoticetitlevalue.text = nt.nTitle
            lblnotice.text = nt.nBody
            
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        lblnoticetitlevalue.frame = CGRect(x: 20, y: 80, width: view.frame.size.width-40, height: 30)
        lblnotice.frame = CGRect(x: 20, y: 120, width: view.frame.size.width, height: 30)
    }
   

}
