//
//  Product.swift
//  GoodAsOldPhones
//
//  Created by Xuanyi Liu on 2017/2/8.
//  Copyright © 2017年 Xuanyi Liu. All rights reserved.
//

import Foundation

struct Product {
    var name: String
    var cellImageName: String
    var fullscreenImageName: String
    
    init(name: String, cellImageName: String, fullscreenImageName: String) {
        self.name = name
        self.cellImageName = cellImageName
        self.fullscreenImageName = fullscreenImageName
    }
}
