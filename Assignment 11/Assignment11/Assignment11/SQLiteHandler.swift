

import Foundation
import SQLite3

class SQLiteHandler
{
    static let shared = SQLiteHandler()
    
    let dbpath = "StudentDB1.sqlite"
    var db:OpaquePointer? // DBPONITER
    
    private init()
    {
        db = openDatabase()
        createTable()
    }
    
    func openDatabase() -> OpaquePointer? {
        
        let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = docURL.appendingPathComponent(dbpath)
        
        var database : OpaquePointer? = nil
        
        if sqlite3_open(fileURL.path, &database) == SQLITE_OK
        {
            print("Opened Connection to the database successfully at : \(fileURL)")
            return database
        }
        else {
            print("error eonnecting to the database")
            return nil
        }
       
    }
    
    
    func createTable()
    {
        let CreateTableString = """
        CREATE TABLE IF NOT EXISTS StudentNew(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        spid INTEGER,
        name TEXT,
        dob TEXT,
        gender TEXT,
        class_name TEXT,
        password TEXT);
        """

        var CreateTableStatement : OpaquePointer? = nil
        //PREPARE STATEMENT
        if sqlite3_prepare(db, CreateTableString, -1, &CreateTableStatement,nil) == SQLITE_OK
        {
            //EVALUEATE STATEMENT
            if sqlite3_step(CreateTableStatement) == SQLITE_DONE {
                print("Student table created")
            } else {
                print("Student table could not be Evaluate")
            }
        }
        else
        {
            print("Student Table Could Not Be Prepared")
        }
        sqlite3_finalize(CreateTableStatement)
    }


    
    func fetch() -> [Student]{
        let fetchStatementString = "SELECT * FROM StudentNew;"
        
        var fetchStatement:OpaquePointer? = nil
        
        var stud = [Student]()
        
        //prepare fetchStatement
        if sqlite3_prepare_v2(db, fetchStatementString, -1 ,&fetchStatement, nil) == SQLITE_OK {
            
            //Evaluate statement
            while sqlite3_step(fetchStatement) == SQLITE_ROW {
                print("fetchd row succesfully")
                let id = Int(sqlite3_column_int(fetchStatement, 0))
                let spid = Int(sqlite3_column_int(fetchStatement, 1))
                let name = String(cString: sqlite3_column_text(fetchStatement, 2))
                let dob = String(cString: sqlite3_column_text(fetchStatement, 3))
                let gender = String(cString: sqlite3_column_text(fetchStatement, 4))
                let classname = String(cString: sqlite3_column_text(fetchStatement, 5))
                let password = String(cString: sqlite3_column_text(fetchStatement, 6))
                stud.append(Student(id: id, spid: spid, name: name, dob: dob, gender: gender, classname: classname, password: password))
                print("\(id) |  \(spid)  |  \(name)  |  \(dob) | \(gender) | \(classname)  | \(password)")
                
            }
        }
        else
        {
            print("fetch statement could not be prepared")
        }
        
        //delete fetchstatement
        sqlite3_finalize(fetchStatement)
        
        return stud
    }
    
    
    func insert(std:Student, completion: @escaping ((Bool) -> Void)) {
        let insertStatementString = "INSERT INTO StudentNew(spid,name,dob,gender,class_name,password) VALUES(?,?,?,?,?,?);"
        
        var insertStatement:OpaquePointer? = nil
        
        //prepare insertStatement
        if sqlite3_prepare_v2(db, insertStatementString, -1 ,&insertStatement, nil) == SQLITE_OK {
            print("In prepared")
            //Binding data
            //sqlite3_bind_text(insertStatement, 1, (std.spid as NSString).utf8String, -1, nil)
            //let password  = String(std.spid)
            
            sqlite3_bind_int(insertStatement, 1, Int32(std.spid))
            sqlite3_bind_text(insertStatement, 2, (std.name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (std.dob as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (std.gender as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (std.classname as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, (String(std.spid) as NSString).utf8String, -1, nil)
            //Evaluate statement
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("inserted row succesfully")
                completion(true)
            } else {
                print("could not insert row")
                completion(false)
            }
            
        }
        else
        {
            print("insert statement could not be prepared")
            completion(false)
        }
        
        //delete insertstatement
        sqlite3_finalize(insertStatement)
        
    }
    
    
    func update(std:Student, completion: @escaping ((Bool) -> Void)) {
       
        let updateStatementString = "UPDATE StudentNew SET spid = ?, name = ?, dob = ? ,gender = ?,class_name = ?,password = ?     WHERE id = ?;"
        
        var updateStatement:OpaquePointer? = nil
        
        //prepare insertStatement
        if sqlite3_prepare_v2(db, updateStatementString, -1 ,&updateStatement, nil) == SQLITE_OK {
            
            //Binding data
           
             sqlite3_bind_int(updateStatement, 1, Int32(std.spid))
             sqlite3_bind_text(updateStatement, 2, (std.name as NSString).utf8String, -1, nil)
             sqlite3_bind_text(updateStatement, 3, (std.dob as NSString).utf8String, -1, nil)
             sqlite3_bind_text(updateStatement, 4, (std.gender as NSString).utf8String, -1, nil)
             sqlite3_bind_text(updateStatement, 5, (std.classname as NSString).utf8String, -1, nil)
             sqlite3_bind_text(updateStatement, 6, (String(std.spid) as NSString).utf8String, -1, nil)
            sqlite3_bind_int(updateStatement, 7, Int32(std.id))
            //Evaluate statement
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("updated row succesfully")
                completion(true)
            } else {
                print("could not update row")
                completion(false)
            }
            
        }
        else
        {
            print("UPDATE statement could not be prepared")
            completion(false)
        }
        
        //delete insertstatement
        sqlite3_finalize(updateStatement)
        
    }
    func delete(for id:Int, completion: @escaping ((Bool) -> Void)) {
        let deleteStatementString = "DELETE FROM StudentNew WHERE id = ?;"
        
        var deleteStatement:OpaquePointer? = nil
        
        //prepare deleteStatement
        if sqlite3_prepare_v2(db, deleteStatementString, -1 ,&deleteStatement, nil) == SQLITE_OK {
            
            //Binding data
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            
            //Evaluate statement
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("deleted row succesfully")
                completion(true)
            } else {
                print("could not delete row")
                completion(false)
            }
            
        }
        else
        {
            print("Delete statement could not be prepared")
            completion(false)
        }
        
        //delete deletestatement
        sqlite3_finalize(deleteStatement)
        
    }
    
    
    func fetchbyclass(for classname:String) -> [Student]{
        let fetchStatementString = "SELECT * FROM StudentNew Where class_name = ? ;"
        
        var fetchStatement:OpaquePointer? = nil
        
        var stud = [Student]()
        
        //prepare fetchStatement
        if sqlite3_prepare_v2(db, fetchStatementString, -1 ,&fetchStatement, nil) == SQLITE_OK {
            
            //Evaluate statement
            sqlite3_bind_text(fetchStatement, 1, (classname as NSString).utf8String, -1, nil)
            while sqlite3_step(fetchStatement) == SQLITE_ROW {
                print("fetchd row succesfully")
                let id = Int(sqlite3_column_int(fetchStatement, 0))
                let spid = Int(sqlite3_column_int(fetchStatement, 1))
                let name = String(cString: sqlite3_column_text(fetchStatement, 2))
                let dob = String(cString: sqlite3_column_text(fetchStatement, 3))
                let gender = String(cString: sqlite3_column_text(fetchStatement, 4))
                let classname = String(cString: sqlite3_column_text(fetchStatement, 5))
                let password = String(cString: sqlite3_column_text(fetchStatement, 6))
                stud.append(Student(id: id, spid: spid, name: name, dob: dob, gender: gender, classname: classname, password: password))
                print("\(id) |  \(spid)  |  \(name)  |  \(dob) | \(gender) | \(classname)  | \(password)")
                
            }
        }
        else
        {
            print("fetch statement could not be prepared")
        }
        
        //delete fetchstatement
        sqlite3_finalize(fetchStatement)
        
        return stud
    }
    
    func LoginCheck(for spid:Int, for password : String) -> Int{
        let fetchStatementString = "SELECT COUNT(*) FROM StudentNew Where spid = ? and password = ?;"
        
        var fetchStatement:OpaquePointer? = nil
       
        var loginstatus : Int? = 0
        //prepare fetchStatement
        if sqlite3_prepare_v2(db, fetchStatementString, -1 ,&fetchStatement, nil) == SQLITE_OK {
            
            //Evaluate statement
            sqlite3_bind_int(fetchStatement, 1, Int32(spid))
            sqlite3_bind_text(fetchStatement, 2, (password as NSString).utf8String, -1, nil)
            
            if sqlite3_step(fetchStatement) == SQLITE_ROW
            {
                 loginstatus = Int(sqlite3_column_int(fetchStatement, 0))
                 print("\(loginstatus)\t")
            }
        }
        else
        {
            print("fetch statement could not be prepared")
        }
        
        //delete fetchstatement
        sqlite3_finalize(fetchStatement)
        
        return loginstatus!
    }
    
    
    //profile
    
    func fetchprof(for spid:Int) -> [Student]{
        let fetchStatementString = "SELECT * FROM StudentNew Where spid = ? ;"
        
        var fetchStatement:OpaquePointer? = nil
        
        var stud = [Student]()
        
        //prepare fetchStatement
        if sqlite3_prepare_v2(db, fetchStatementString, -1 ,&fetchStatement, nil) == SQLITE_OK {
            
            //Evaluate statement
            sqlite3_bind_int(fetchStatement, 1, Int32(spid))
            while sqlite3_step(fetchStatement) == SQLITE_ROW {
                print("fetchd row succesfully")
                let id = Int(sqlite3_column_int(fetchStatement, 0))
                let spid = Int(sqlite3_column_int(fetchStatement, 1))
                let name = String(cString: sqlite3_column_text(fetchStatement, 2))
                let dob = String(cString: sqlite3_column_text(fetchStatement, 3))
                let gender = String(cString: sqlite3_column_text(fetchStatement, 4))
                let classname = String(cString: sqlite3_column_text(fetchStatement, 5))
                let password = String(cString: sqlite3_column_text(fetchStatement, 6))
                stud.append(Student(id: id, spid: spid, name: name, dob: dob, gender: gender, classname: classname, password: password))
                print("\(id) |  \(spid)  |  \(name)  |  \(dob) | \(gender) | \(classname)  | \(password)")
                
            }
        }
        else
        {
            print("fetch statement could not be prepared")
        }
        
        //delete fetchstatement
        sqlite3_finalize(fetchStatement)
        
        return stud
    }
    
    
    
    
    
    func updatepass(for spid:Int,for password : String, completion: @escaping ((Bool) -> Void)) {
        
        let updateStatementString = "UPDATE StudentNew SET password = ?  WHERE spid = ?;"
        
        var updateStatement:OpaquePointer? = nil
        
        //prepare insertStatement
        if sqlite3_prepare_v2(db, updateStatementString, -1 ,&updateStatement, nil) == SQLITE_OK {
            
            //Binding data
              sqlite3_bind_text(updateStatement, 1, (password as NSString).utf8String, -1, nil)
            sqlite3_bind_int(updateStatement, 2, Int32(spid))
          
          
            //Evaluate statement
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("updated row succesfully")
                completion(true)
            } else {
                print("could not update row")
                completion(false)
            }
            
        }
        else
        {
            print("UPDATE statement could not be prepared")
            completion(false)
        }
        
        //delete insertstatement
        sqlite3_finalize(updateStatement)
        
    }
    
    
    
    
    
    
    
    
    
}
