//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Mike"
        newItem.done = true
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Three"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Turn On"
        itemArray.append(newItem3)
//        if let items = defaults.array(forKey: "TodoListArray") as? [String]{
//            itemArray = items
//        }
    }

    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //L : method의 파라미터로 tableView
        //V : Variable으로 외부에서 쓰이는, global한
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
//        if item.done == true{
//            cell.accessoryType = .checkmark
//        } else{
//            cell.accessoryType = .none
//        }
        return cell
    }
    
    //MARK: - TableView Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
//        밑에 다섯줄과 동알힘. 한줄로 정의 가능
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else{
//            itemArray[indexPath.row].done = false
//        }
        
        tableView.reloadData() // 하지 않으면 체크 표시 동작 안됨, 테이블에 있는 셀들 모두 다시 동작
        
        tableView.deselectRow(at: indexPath, animated: true) //셀 선택되고 다시 하얀색으로
        
        
    }
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //add item 버튼 클릭시 일어날 일들
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "TodoListArray") 
            self.tableView.reloadData() //새로운 값이 들어올 때 다시 로드
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}


