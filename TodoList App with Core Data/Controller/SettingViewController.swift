//
//  SettingViewController.swift
//  TodoList App with Core Data
//
//  Created by Kemo on 4/29/19.
//  Copyright © 2019 kodechamp. All rights reserved.
//

import UIKit
import UserNotifications
class SettingViewController: UIViewController {
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var colorButton: UIButton!
    @IBOutlet weak var colorNameLabel: UILabel!
    
    var dropDown = DropDown()
    let itemObject = CategoryEntity()
    var colorArray = ["blue","gray","light green"]
    var colorHexArray = ["#2a7fba","#222222","#49535a"]
    var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(changeButtonColor), name: NSNotification.Name("changeButtonColor"), object: nil)
        inintDrobDown ()
        colorNameLabel.text = colorArray[0]
        // Do any additional setup after loading the view.
    }
    @objc func changeButtonColor (){
        checkNotificationAut()

    }
    @IBAction func notificationButtonAction(_ sender: Any) {
        UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!)

    }
    
    @IBAction func colorButtonAction(_ sender: Any) {
        dropDown.show()
    }
    
    
    
    @IBAction func saveButtonAction(_ sender: Any) {
        if categoryTextField.text?.isEmpty == true {
            let alaer = UIAlertController(title: "Please add Category name", message:"", preferredStyle: .alert)
            
            self.present(alaer, animated: true, completion: nil)
            
            let action = UIAlertAction(title: "OK", style: .default){
                (ACTION:UIAlertAction)
                in }
            alaer.addAction(action)
            
        }
        
        itemObject.categoryName = categoryTextField.text!
        itemObject.colorHex = colorHexArray[index]
        HandellingCategoryObject.set(category_model: itemObject)
        self.navigationController?.popViewController(animated: true)
    }
  
    func inintDrobDown () {
     
        dropDown.anchorView = categoryView
        dropDown.dataSource = colorArray
        dropDown.reloadAllComponents()
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            //self.itemObject.colorHex = self.colorHexArray[index]
            self.index = index
            self.dropDown.hide()
            
        }
        
    }
    

    
    func checkNotificationAut ()  {
        let center = UNUserNotificationCenter.current()
        
        center.getNotificationSettings { (settings) in
            if settings.authorizationStatus != .authorized {
            
                self.notificationButton.layer.backgroundColor = UIColor.red.cgColor

            }
            
            else {
                
                self.notificationButton.layer.backgroundColor = UIColor.green.cgColor

            }
            
        }
        
     
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
