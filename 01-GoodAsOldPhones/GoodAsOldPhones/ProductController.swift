//
//  ProductController.swift
//  GoodAsOldPhones
//
//  Created by Xuanyi Liu on 2017/2/8.
//  Copyright © 2017年 Xuanyi Liu. All rights reserved.
//

import UIKit

class ProductController: UIViewController {
    
    var product: Product!

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        title = product.name
        
        productNameLabel.text = product.name
        productImageView.image = UIImage(named: product.fullscreenImageName)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addToCartAction(_ sender: UIButton) {
        print("Hello World!")
    }

}
