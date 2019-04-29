//
//  HandellingExpressOrder.swift
//  TodoList App with Core Data
//
//  Created by Kemo on 4/28/19.
//  Copyright © 2019 kodechamp. All rights reserved.
//
import UIKit
import CoreData

class ToDoViewController: UITableViewController {
    @IBOutlet var categoryTableView: UITableView!
    
    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        categoryTableView.register(UINib(nibName: "CategoryTableViewCell" , bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")

    }

    override func viewWillAppear(_ animated: Bool) {
       loadCategories()
    }
    
    //MARK: TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell

        let category = categories[indexPath.row]
        cell.categoryValueLabel.text = category.name
        cell.completionValueLabel.text = category.completionDate
        cell.categoryNameValue.text = category.categoryName
        let hexcolorValue = UIColor(hex:category.categoryColor!)
        cell.categoryView.backgroundColor =  hexcolorValue
    
        return cell
        
    }
    
    //MARK: TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToEdit", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let destinationVC = segue.destination as! TaskDetailsViewController
       
        switch segue.identifier {
        case "goToEdit":
            let destinationVC = segue.destination as! TaskDetailsViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedCategory = categories[indexPath.row]
                destinationVC.updateState = true
                destinationVC.index = indexPath.row
                destinationVC.categories = categories
            }
            
        case "goToSetting":
            let destination = segue.destination as! SettingViewController
            
        default: break
        }

        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == .delete) {
            let category = categories[indexPath.row]
            categories.remove(at: indexPath.row)
    
            context.delete(category)
            
            do {
                try context.save()
            } catch {
                print("Error deleting category with \(error)")
            }
              self.categoryTableView.deleteRows(at: [indexPath], with: .automatic)  //includes updating UI so reloading is not necessary
        }
    }

    
    
    //MARK: Data Manipulation Methods
    
    func saveCategories(){
        
        do{
            try context.save()
        }catch {
            print("Error saving category with \(error)")
        }
        
        self.categoryTableView.reloadData()

    }
    
    
    func loadCategories(){
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categories = try context.fetch(request)
        }catch{
            print("Error fetching data from context \(error)")
        }
        
       self.categoryTableView.reloadData()
    }
    
    
    
    
    

        
}
    


