//
//  LapsCell.swift
//  Stopwatch
//
//  Created by Xuanyi Liu on 2017/2/8.
//  Copyright © 2017年 Xuanyi Liu. All rights reserved.
//

import UIKit

class LapsCell: UITableViewCell {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var numLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
