//
//  Stopwatch.swift
//  Stopwatch
//
//  Created by Xuanyi Liu on 2017/2/8.
//  Copyright © 2017年 Xuanyi Liu. All rights reserved.
//

import Foundation

class Stopwatch {
    var counter: Double
    var timer: Timer
    
    init() {
        self.counter = 0.0
        self.timer = Timer()
    }
}
