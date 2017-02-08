//
//  ViewController.swift
//  LoveTweet
//
//  Created by Xuanyi Liu on 2017/2/8.
//  Copyright © 2017年 Xuanyi Liu. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController {
    
    var name: String? {
        if let username = nameTextField.text {
            return username
        }
        else {
            return nil
        }
    }
    var gender: String {
        get {
            if genderSegmentControl.selectedSegmentIndex == 0 {
                return "Men"
            } else {
                return "Women"
            }
        }
    }
    
    var birthday: Date {
        get {
            return birthdayPicker.date
        }
    }
    
    var age: String? {
        get {
            let gregorian = Calendar(identifier: Calendar.Identifier.gregorian)
            let now = Date()
            let components = gregorian.dateComponents([.day, .month, .year], from: birthdayPicker.date, to: now)
            if let a = components.year {
                return "\(a)"
            }
            return nil
        }
    }
    
    var work: String? {
        get {
            if let t_work = workTextField.text {
                return t_work
            }
            else {
                return nil
            }
        }
    }
    
    var salary: String? {
        get {
            if let value = salaryLabel.text {
                if value == "" {
                    return nil
                } else {
                    return value
                }
            }
            return nil
        }
    }
    
    var interestedIn: String {
        get {
            if genderSegmentControl.selectedSegmentIndex == 0 && staightSwitch.isOn {
                return "Women"
            } else if genderSegmentControl.selectedSegmentIndex == 0 && !staightSwitch.isOn {
                return "Men"
            } else if genderSegmentControl.selectedSegmentIndex == 1 && staightSwitch.isOn {
                return "Men"
            } else {
                return "Women"
            }
        }
    }

    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var tweetBtn: UIButton!
    @IBOutlet weak var staightSwitch: UISwitch!
    @IBOutlet weak var salarySlider: UISlider!
    @IBOutlet weak var workTextField: UITextField!
    @IBOutlet weak var birthdayPicker: UIDatePicker!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var genderSegmentControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tweetAction(_ sender: UIButton) {
        guard name != nil && work != nil && salary != nil && age != nil else {
            showAlert("Info Miss", message: "Please fill out the form", btnTitle: "OK")
            return
        }
        
        let tweet = "Hi, I am \(name!). As a \(age!)-year-old \(work!) earning \(salary!)/year, I am interested in \(interestedIn). Feel free to contact me!"
        tweetSLCVC(tweet)
    }
    
    @IBAction func salaryAction(_ sender: UISlider) {
        let value = salarySlider.value * 100.0
        if value > 0.0 {
            let v = "$\(Int(value))k"
            salaryLabel.text = v
        }
        else {
            salaryLabel.text = ""
        }
    }
    
    func tweetSLCVC(_ tweet: String) {
        print(tweet)
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
            let twitterController: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterController.setInitialText(tweet)
            present(twitterController, animated: true, completion: nil)
        } else {
            showAlert("Twitter Unavailable", message: "Please configure your twitter account on device", btnTitle: "OK")
        }
    }
    
    func showAlert(_ title: String, message: String, btnTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: btnTitle, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

