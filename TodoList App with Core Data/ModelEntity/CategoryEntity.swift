//
//  CategoryEntity.swift
//  TodoList App with Core Data
//
//  Created by Kemo on 4/28/19.
//  Copyright © 2019 kodechamp. All rights reserved.
//

import Foundation

class CategoryEntity:NSObject
{
    var categoryName:String = ""
    var colorHex:String = ""
}


import Foundation
class User: NSObject {
    
    class func searchresult() -> [String] {
        
        return  UserDefaults.standard.stringArray(forKey: "searchresult") ?? []
    }
    
    class func setsearchresult(searchresult:[String]) {
        UserDefaults.standard.set(searchresult, forKey: "searchresult")
    }
    
    
}
