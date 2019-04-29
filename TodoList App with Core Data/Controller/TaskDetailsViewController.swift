//
//  TaskDetailsViewController.swift
//  TodoList App with Core Data
//
//  Created by Kemo on 4/28/19.
//  Copyright © 2019 kodechamp. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

class TaskDetailsViewController: UIViewController {
    @IBOutlet weak var completionDateTextBox: UITextField!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var categoryValueLabel: UILabel!
    @IBOutlet weak var chooseCategoruButton: UIButton!
    @IBOutlet weak var nameTextBox: UITextField!
    @IBOutlet weak var categoryColorView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    
     var categories = [Category]()
     var categoryNames = [String]()
     var dropDown = DropDown()
     let datePicker = UIDatePicker()
     var categoryColor = ""
    var dateTimeInterval:Double = 0.0
    var updateState = false
    var index = 0
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var selectedCategory: Category?{
            didSet{
            }
        }
     override func viewDidLoad() {
        super.viewDidLoad()
         registerLocal()
        showDatePicker()
        inintDrobDown ()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if updateState == true {
            
            self.nameTextBox.text = selectedCategory?.name
            self.completionDateTextBox.text = selectedCategory?.completionDate
            self.categoryValueLabel.text = selectedCategory?.categoryName
            let hexcolorValue = UIColor(hex:(selectedCategory?.categoryColor)!)
            self.categoryColorView.backgroundColor = hexcolorValue
            
        }
    }
    
    @IBAction func chooseCategoryButtonAction(_ sender: Any) {
        if HandellingCategoryObject.get().isEmpty == true{
            let alaer = UIAlertController(title: "Please add Category from setting screen", message:"", preferredStyle: .alert)
            
            self.present(alaer, animated: true, completion: nil)
            
            let action = UIAlertAction(title: "OK", style: .default){
                (ACTION:UIAlertAction)
                in }
            alaer.addAction(action)
            
        }
        else {
               self.dropDown.show()
        }
       
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        
        
        
        if updateState == false {
            if self.nameTextBox.text?.isEmpty == true || self.completionDateTextBox.text?.isEmpty == true || self.categoryValueLabel.text?.isEmpty == true ||  categoryNames.isEmpty == true {
                
                let alaer = UIAlertController(title: "Please complete the data", message:"", preferredStyle: .alert)
                
                self.present(alaer, animated: true, completion: nil)
                
                let action = UIAlertAction(title: "OK", style: .default){
                    (ACTION:UIAlertAction)
                    in }
                alaer.addAction(action)
            }
            
            else {
            
        let newCategory = Category(context: self.context)
        newCategory.name = self.nameTextBox.text!
        newCategory.completionDate = self.completionDateTextBox.text!
        newCategory.categoryColor = categoryColor
        newCategory.categoryName = self.categoryValueLabel.text
        self.categories.append(newCategory)
         self.saveItems()
        addNotification(title: self.completionDateTextBox.text!, body: self.categoryValueLabel.text!)
                self.navigationController?.popViewController(animated: true)

            }
        }
        
        else {
            
            if self.nameTextBox.text?.isEmpty == true || self.completionDateTextBox.text?.isEmpty == true || self.categoryValueLabel.text?.isEmpty == true  || categoryNames.isEmpty == true{
                
                let alaer = UIAlertController(title: "Please complete the data", message:"", preferredStyle: .alert)
                
                self.present(alaer, animated: true, completion: nil)
                
                let action = UIAlertAction(title: "OK", style: .default){
                    (ACTION:UIAlertAction)
                    in }
                alaer.addAction(action)
            }
            else {
            categories[index].categoryColor = categoryColor
            categories[index].name = self.nameTextBox.text!
            categories[index].completionDate = self.completionDateTextBox.text!
            categories[index].categoryName = self.categoryValueLabel.text
            saveItems()
                self.navigationController?.popViewController(animated: true)

            }
        }
    }
    
    
    ////////Add Notificaion funcion//////////
    func addNotification(title:String,body:String){
        
        
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title =  title
        content.body = body
        //timeInterval:dateTimeInterval
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval:5 , repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.delegate = self
        center.add(request, withCompletionHandler: nil)
        
        
    }
    /////////////register local Notification/////////
    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Yay!")
            } else {
                print("D'oh")
            }
        }
    }
    
    func saveItems(){
        do{
            try context.save()
        }catch {
            print("Error saving category with \(error.localizedDescription)")
        }
    }
    
    

    func inintDrobDown () {
        categoryNames.removeAll()
        for item in HandellingCategoryObject.get() {
            categoryNames.append(item.categoryName )
        }
        dropDown.anchorView = categoryView
        dropDown.dataSource = categoryNames
        dropDown.reloadAllComponents()
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.categoryValueLabel.text = item
            let hexcolorValue = UIColor(hex:HandellingCategoryObject.get()[index].colorHex)
            self.categoryColorView.backgroundColor = hexcolorValue
            self.categoryColor = HandellingCategoryObject.get()[index].colorHex
           
            self.dropDown.hide()

        }
        
    }
    
    //////////Dates pocker Configuiration/////
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .dateAndTime
        let currentDate = Date()
        datePicker.minimumDate = currentDate
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        completionDateTextBox.inputAccessoryView = toolbar
        completionDateTextBox.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm a"
        completionDateTextBox.text = formatter.string(from: datePicker.date)
        dateTimeInterval =  datePicker.date.timeIntervalSinceNow

        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }


}


