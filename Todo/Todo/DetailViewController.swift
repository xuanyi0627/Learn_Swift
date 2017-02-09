//
//  DetailViewController.swift
//  Todo
//
//  Created by Xuanyi Liu on 2017/2/9.
//  Copyright © 2017年 Xuanyi Liu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var childButton: UIButton!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var shoppingCartButton: UIButton!
    @IBOutlet weak var travelButton: UIButton!
    @IBOutlet weak var todoTitleLabel: UITextField!
    @IBOutlet weak var todoDatePicker: UIDatePicker!
    
    var todoType: TodoType? {
        didSet {
            childButton.isSelected = false
            phoneButton.isSelected = false
            shoppingCartButton.isSelected = false
            travelButton.isSelected = false
        }
    }
    
    var todoItem: ToDoItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        if todoItem == nil {
            title = "New Todo"
        } else {
            title = "Edit Todo"
            todoType = todoItem.type
            switch todoItem.type {
            case .child:
                childButton.isSelected = true
            case .phone:
                phoneButton.isSelected = true
            case .shopping:
                shoppingCartButton.isSelected = true
            case .travel:
                travelButton.isSelected = true
            }
            todoTitleLabel.text = todoItem.title
            todoDatePicker.setDate(todoItem.date, animated: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectChild(_ sender: AnyObject) {
        todoType = TodoType.child
        childButton.isSelected = true
    }
    
    @IBAction func selectPhone(_ sender: AnyObject) {
        todoType = TodoType.phone
        phoneButton.isSelected = true
    }
    
    @IBAction func selectShoppingCart(_ sender: AnyObject) {
        todoType = TodoType.shopping
        shoppingCartButton.isSelected = true
    }
    
    @IBAction func selectTravel(_ sender: AnyObject) {
        todoType = TodoType.travel
        travelButton.isSelected = true
    }
    
    @IBAction func tapDone(_ sender: AnyObject) {
        if todoItem == nil {
            let uuid = UUID().uuidString
            guard let type = todoType else {
                return
            }
            guard let title = todoTitleLabel.text else {
                return
            }
            todoItem = ToDoItem(uid: uuid, type: type, title: title, date: todoDatePicker.date)
            todos.append(todoItem)
        } else {
            todoItem.type = todoType!
            if let title = todoTitleLabel.text {
                todoItem.title = title
            }
            todoItem.date = todoDatePicker.date
        }
        _ = self.navigationController?.popViewController(animated: true)
    }

}
