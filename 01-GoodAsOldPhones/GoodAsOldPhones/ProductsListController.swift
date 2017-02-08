//
//  ProductsListController.swift
//  GoodAsOldPhones
//
//  Created by Xuanyi Liu on 2017/2/8.
//  Copyright © 2017年 Xuanyi Liu. All rights reserved.
//

import UIKit

class ProductsListController: UITableViewController {
    
    var products: [Product]?

    override func viewDidLoad() {
        super.viewDidLoad()

        products = [
            Product(name: "1907 Wall Set", cellImageName: "image-cell1", fullscreenImageName: "phone-fullscreen1"),
            Product(name: "1921 Dial Phone", cellImageName: "image-cell2", fullscreenImageName: "phone-fullscreen2"),
            Product(name: "1937 Desk Set", cellImageName: "image-cell3", fullscreenImageName: "phone-fullscreen3"),
            Product(name: "1984 Moto Portable", cellImageName: "image-cell4", fullscreenImageName: "phone-fullscreen4")
        ]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let list = products {
            return list.count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath)
        if let product = products?[indexPath.row] {
            cell.textLabel?.text = product.name
            cell.imageView?.image = UIImage(named: product.cellImageName)
        }
        else {
            cell.textLabel?.text = "NULL"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let product = products?[indexPath.row] {
            performSegue(withIdentifier: "showProduct", sender: product)
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "showProduct" {
                let productVC = segue.destination as! ProductController
                productVC.product = sender as! Product
            }
        }
    }
}
