

import Foundation
import SQLite3
class SQLiteHandler2
{
    static let shared = SQLiteHandler2()
    
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
        CREATE TABLE IF NOT EXISTS StudentNotice(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nTitle TEXT,
        nBody TEXT)
        """
        
        var CreateTableStatement : OpaquePointer? = nil
        //PREPARE STATEMENT
        if sqlite3_prepare(db, CreateTableString, -1, &CreateTableStatement,nil) == SQLITE_OK
        {
            //EVALUEATE STATEMENT
            if sqlite3_step(CreateTableStatement) == SQLITE_DONE {
                print("Notice table created")
            } else {
                print("Notice table could not be Evaluate")
            }
        }
        else
        {
            print("Notice Table Could Not Be Prepared")
        }
        sqlite3_finalize(CreateTableStatement)
    }
    
    func insert(nt:Notice, completion: @escaping ((Bool) -> Void)) {
        let insertStatementString = "INSERT INTO StudentNotice(nTitle,nBody) VALUES(?,?);"
        
        var insertStatement:OpaquePointer? = nil
        
        //prepare insertStatement
        if sqlite3_prepare_v2(db, insertStatementString, -1 ,&insertStatement, nil) == SQLITE_OK {
            print("In prepared")
            //Binding data
            
            
            sqlite3_bind_text(insertStatement, 1, (nt.nTitle as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (nt.nBody as NSString).utf8String, -1, nil)
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
    func fetch() -> [Notice]{
        let fetchStatementString = "SELECT * FROM StudentNotice;"
        
        var fetchStatement:OpaquePointer? = nil
        
        var nt = [Notice]()
        
        //prepare fetchStatement
        if sqlite3_prepare_v2(db, fetchStatementString, -1 ,&fetchStatement, nil) == SQLITE_OK {
            
            //Evaluate statement
            while sqlite3_step(fetchStatement) == SQLITE_ROW {
                print("fetchd row succesfully")
                let id = Int(sqlite3_column_int(fetchStatement, 0))
                let nTitle = String(cString: sqlite3_column_text(fetchStatement, 1))
                let nBody = String(cString: sqlite3_column_text(fetchStatement, 2))
             
                nt.append(Notice(id: id, nTitle: nTitle, nBody: nBody))
                print("\(id) |  \(nTitle)  |  \(nBody)")
                
            }
        }
        else
        {
            print("fetch statement could not be prepared")
        }
        
        //delete fetchstatement
        sqlite3_finalize(fetchStatement)
        
        return nt
    }
    
    func update(nt:Notice, completion: @escaping ((Bool) -> Void)) {
        
        let updateStatementString = "UPDATE StudentNotice SET nTitle = ?, nbody = ? WHERE id = ?;"
        
        var updateStatement:OpaquePointer? = nil
        
        //prepare insertStatement
        if sqlite3_prepare_v2(db, updateStatementString, -1 ,&updateStatement, nil) == SQLITE_OK {
            
            //Binding data
            
          
            sqlite3_bind_text(updateStatement, 1, (nt.nTitle as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 2, (nt.nBody as NSString).utf8String, -1, nil)
            sqlite3_bind_int(updateStatement, 3, Int32(nt.id))
    
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
        let deleteStatementString = "DELETE FROM StudentNotice WHERE id = ?;"
        
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
}
