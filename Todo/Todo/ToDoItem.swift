//
//  ToDoItem.swift
//  Todo
//
//  Created by Xuanyi Liu on 2017/2/9.
//  Copyright © 2017年 Xuanyi Liu. All rights reserved.
//

import Foundation

enum TodoType {
    case child
    case phone
    case shopping
    case travel
}

class ToDoItem {
    var uid: String
    var type: TodoType
    var title: String
    var date: Date
    
    init(uid u_id: String, type: TodoType, title: String, date: Date) {
        self.uid = u_id
        self.type = type
        self.title = title
        self.date = date
    }
}
