//
//  TodoListViewController.swift
//  Todos
//
//  Created by John C. Kennedy on 2019/03/17.
//  Copyright © 2019 John C. Kennedy. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    // Create user defaults for persistence
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy Eggos"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Destroy Demogorgon"
        itemArray.append(newItem3)
        
        // Load user defaults
        if let items = defaults.array(forKey: "TodoList") as? [Item] {
            itemArray = items
        }
    }

    // MARK - Tabelview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        // Set cell text
        cell.textLabel?.text = item.title
        
        // Give selected row a checkmark accessory
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    // MARK - Tabelview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        // Remove highlight after selecting a row
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newItem = Item()
            newItem.title = textField.text!
            
            // Add item to itemArray
            self.itemArray.append(newItem)
            
            // Store in user defaults
            self.defaults.set(self.itemArray, forKey: "TodoList")
            
            // Reload table data
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        // Add action to alert
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}

