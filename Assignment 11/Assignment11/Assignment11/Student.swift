

import Foundation

class Student
{
    var id : Int = 0
    var spid : Int = 0
    var name : String = ""
    var dob : String = ""
    var gender : String = ""
    var classname : String = ""
    var password : String = ""
    init(id : Int,spid : Int,name : String , dob : String ,gender : String , classname : String,password : String) {
        self.id = id
        self.spid = spid
        self.name = name
        self.dob = dob
        self.gender = gender
        self.classname = classname
        self.password = password
    }
    
}
