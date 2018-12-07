//
//  ViewController.swift
//  Todoey
//
//  Created by Apple on 04/12/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController{
    
    var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        

        let newItem = Item()
        newItem.title = "Find Make"
        
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Sumit"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Shiva Labs"
        itemArray.append(newItem3)
        
   
      loadItems()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
       
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
       
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
     itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
      
        
       
       saveItems()
    
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Mark 
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert
        )
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
          let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            self.saveItems()
         
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
            textField = alertTextField
          
            print("Now")
            
        }
        alert.addAction(action)
        
        present(alert,animated: true,completion: nil)
    }
    
    //MARK- Model Manupalation Method
    func saveItems(){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            
            print("Error encoding item Array")
            
        }
        self.tableView.reloadData()
        
    }
    
    func loadItems(){
      if  let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            
            do {
                 itemArray = try decoder.decode([Item].self, from: data)
            }  catch {
                print("Error decoding item Array ,\(error)")
            }
            
           
        }
    }
    
    
    

}

