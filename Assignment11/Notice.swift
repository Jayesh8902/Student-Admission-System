//
//  Notice.swift
//  Assignment11
//
//  Created by DCS on 18/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import Foundation
class Notice
{
    var id : Int = 0
    var nTitle : String = ""
    var nBody : String = ""
  
    init(id : Int,nTitle : String,nBody : String) {
        self.id = id
        self.nTitle = nTitle
        self.nBody = nBody
    }
}
