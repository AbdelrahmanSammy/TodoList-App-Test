//
//  HandellingExpressOrder.swift
//  TodoList App with Core Data
//
//  Created by Kemo on 4/28/19.
//  Copyright © 2019 kodechamp. All rights reserved.
//

import UIKit

class HandellingCategoryObject: NSObject {
    
    private static var categoryInfoArray = [CategoryEntity]()
    private static var Category_KEY = "Category_KEY"
    
    
    class func get()->[CategoryEntity]{
        
        if self.categoryInfoArray.count == 0 {
            let tempPureArray = self.getPureDataFromUserDefuald()
            self.categoryInfoArray.removeAll()
            for infoArray in tempPureArray {
                let handelModel = self.convertFromArrayToString(category: infoArray as [String : AnyObject])
                self.categoryInfoArray.append(handelModel)
            }
            return  self.categoryInfoArray
        }
        return self.categoryInfoArray
    }
    
    class func removeAll(){
        
        
        let userDefualt = UserDefaults()
        userDefualt.removeObject(forKey: Category_KEY)
        userDefualt.synchronize()
        categoryInfoArray.removeAll()
        print("Removed")
        
    }
    
    
    class func set(category_model :CategoryEntity){
        
        let df = UserDefaults()
        var tempPureArray = self.getPureDataFromUserDefuald()
        let category = self.convertFromModelToArray(category_model: category_model)
        tempPureArray.append(category)
        df.set(tempPureArray, forKey: Category_KEY)
        df.synchronize()
        
        self.categoryInfoArray.removeAll()
        
    }
    
//    class func update(busket_model :CategoryEntity){
//        //
//
//        var tempPureArray = self.getPureDataFromUserDefuald()
//        let product_id = (busket_model.id as String?) ?? ""
//
//        for i in 0..<tempPureArray.count {
//            let infoArray  = tempPureArray[i]
//            if infoArray["ProductId"] as! String == product_id {
//                //  tempPureArray.remove(at: i)
//                tempPureArray[i].updateValue(busket_model.NumberProduct as AnyObject, forKey: "NumberProduct")
//
//                //   tempPureArray.append(self.convertFromModelToArray(busket_model: busket_model))
//                //                let tempStringArray = sel÷f.convertFromModelToArray(busket_model: busket_model)
//                let df = UserDefaults()
//                df.set(tempPureArray, forKey: BUSKET_KEY)
//                df.synchronize()
//                self.busketInfoArray.removeAll()
//                //                self.set(busket_model: busket_model)
//                return
//            }
//        }
//
//
//
//    }
//
//    class func delete(busket_model :CategoryEntity){
//
//        var tempPureArray = self.getPureDataFromUserDefuald()
//        let product_id = (busket_model.id as String?) ?? ""
//        //        tempPureArray.removeAll()
//        for i in 0..<tempPureArray.count {
//            let infoArray  = tempPureArray[i]
//            if infoArray["ProductId"] as! String == product_id {
//                tempPureArray.remove(at: i)
//
//                let df = UserDefaults()
//                df.set(tempPureArray, forKey: BUSKET_KEY)
//                df.synchronize()
//                self.busketInfoArray.removeAll()
//                //                self.set(busket_model: busket_model)
//                return
//            }
//        }
//
//
//
//    }
    
    
    
    
    public class func getPureDataFromUserDefuald() -> [[String:AnyObject]]{
        var busketInfoArrayString = [[String:AnyObject]]()
        let userDefualt = UserDefaults()
        if let busketData = userDefualt.object(forKey: Category_KEY) as? [[String:AnyObject]] {
            busketInfoArrayString = busketData
        }
        return busketInfoArrayString
    }
    
    private class func convertFromArrayToString (category : [String : AnyObject]) -> CategoryEntity{
        let categoryObject = CategoryEntity()
        
        categoryObject.categoryName = category["categoryName"] as! String
        categoryObject.colorHex = category["colorHex"] as! String
   
       
        return categoryObject
    }
    
    
    private class func convertFromModelToArray (category_model :CategoryEntity) -> [String : AnyObject] {
        let categoryInfo = ["categoryName":category_model.categoryName,
                         "colorHex":category_model.colorHex]
        
        
        return categoryInfo as [String : AnyObject]
        
    }
}
/*
 
 
 
 */
