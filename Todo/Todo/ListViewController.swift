//
//  ListViewController.swift
//  Todo
//
//  Created by Xuanyi Liu on 2017/2/9.
//  Copyright © 2017年 Xuanyi Liu. All rights reserved.
//

import UIKit

var todos: [ToDoItem] = []

class ListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        todos = [
            ToDoItem(uid: "1", type: .child, title: "Go to Disney", date: dateFromString("2014-10-20")!),
            ToDoItem(uid: "2", type: .shopping, title: "Cicso Shopping", date: dateFromString("2014-10-28")!),
            ToDoItem(uid: "3", type: .phone, title: "Phone to Jobs", date: dateFromString("2014-10-30")!),
            ToDoItem(uid: "4", type: .travel, title: "Plan to Europe", date: dateFromString("2014-10-31")!)
        ]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListCell
        let item = todos[indexPath.row]
        setCell(cell, todoItem: item)
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let item = todos.remove(at: fromIndexPath.row)
        todos.insert(item, at: to.row)
    }

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return isEditing
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let todo = todos[indexPath.row]
        performSegue(withIdentifier: "editTodo", sender: todo)
    }
    
    func setCell(_ cell: ListCell, todoItem: ToDoItem) {
        cell.titleLabel.text = todoItem.title
        cell.dateLabel.text = stringFromDate(todoItem.date)
        switch todoItem.type {
        case .child:
            cell.imageView?.image = UIImage(named: "child-selected")
        case .phone:
            cell.imageView?.image = UIImage(named: "phone-selected")
        case .shopping:
            cell.imageView?.image = UIImage(named: "shopping-cart-selected")
        case .travel:
            cell.imageView?.image = UIImage(named: "travel-selected")
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: true)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "editTodo" {
                let vc = segue.destination as! DetailViewController
                vc.todoItem = sender as! ToDoItem
            }
        }
    }

}
