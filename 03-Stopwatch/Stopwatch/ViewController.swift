//
//  ViewController.swift
//  Stopwatch
//
//  Created by Xuanyi Liu on 2017/2/8.
//  Copyright © 2017年 Xuanyi Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var mainStopwatch = Stopwatch()
    var lapStopwatch = Stopwatch()
    
    var isPlay: Bool = false {
        didSet {
            if isPlay {
                changeBtn(lapBtn, title: "Lap", color: UIColor.black, isDisable: false)
                changeBtn(startBtn, title: "Stop", color: UIColor.red, isDisable: false)
                mainStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: Selector.updateMainTimer, userInfo: nil, repeats: true)
                lapStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: Selector.updateLapTimer, userInfo: nil, repeats: true)
            } else {
                changeBtn(startBtn, title: "Start", color: UIColor.green, isDisable: false)
                changeBtn(lapBtn, title: "Reset", color: UIColor.black, isDisable: false)
                mainStopwatch.timer.invalidate()
                lapStopwatch.timer.invalidate()
            }
        }
    }
    
    var isReset: Bool = true {
        didSet {
            if isReset {
                changeBtn(lapBtn, title: "Lap", color: UIColor.gray, isDisable: true)
                changeBtn(startBtn, title: "Start", color: UIColor.green, isDisable: false)
                resetMainTimer()
                resetLapsTimer()
            }
        }
    }
    
    var laps: [String] = []

    @IBOutlet weak var mainTimerLabel: UILabel!
    @IBOutlet weak var lapTimerLabel: UILabel!
    @IBOutlet weak var lapBtn: UIButton!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var lapsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCircleBtn(lapBtn)
        initCircleBtn(startBtn)
        
        isReset = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func initCircleBtn(_ sender: UIButton) {
        sender.layer.cornerRadius = sender.bounds.width / 2
        sender.layer.masksToBounds = true
    }
    
    func changeBtn(_ sender: UIButton, title: String, color: UIColor, isDisable: Bool) {
        var state: UIControlState
        if isDisable {
            state = .disabled
        } else {
            state = .normal
        }
        sender.setTitle(title, for: state)
        sender.setTitleColor(color, for: state)
        sender.isEnabled = !isDisable
    }
    
    func resetTimer(_ stopwatch: Stopwatch, label: UILabel) {
        stopwatch.timer.invalidate()
        stopwatch.counter = 0.0
        label.text = "00:00:00"
    }
    
    func resetMainTimer() {
        resetTimer(mainStopwatch, label: mainTimerLabel)
        laps.removeAll()
        lapsTableView.reloadData()
    }
    
    func resetLapsTimer() {
        resetTimer(lapStopwatch, label: lapTimerLabel)
    }
    
    @IBAction func startAction(_ sender: UIButton) {
        isPlay = !isPlay
    }
    
    @IBAction func lapAction(_ sender: UIButton) {
        if isPlay {
            if let lap = mainTimerLabel.text {
                laps.append(lap)
            }
            lapsTableView.reloadData()
            resetLapsTimer()
            lapStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: Selector.updateLapTimer, userInfo: nil, repeats: true)
        } else {
            isReset = true
        }
    }
    
    //MARK: - TableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lapCell") as! LapsCell
        cell.numLabel.text = "Lap \(laps.count - indexPath.row)"
        cell.timerLabel.text = laps[laps.count - indexPath.row - 1]
        return cell
    }
    
    func updateMainTimer() {
        updateTimer(mainStopwatch, label: mainTimerLabel)
    }
    
    func updateLapTimer() {
        updateTimer(lapStopwatch, label: lapTimerLabel)
    }
    
    func updateTimer(_ stopwatch: Stopwatch, label: UILabel) {
        stopwatch.counter = stopwatch.counter + 0.035
        var minutes: String = "\(Int(stopwatch.counter / 60))"
        if Int(stopwatch.counter / 60) < 10{
            minutes = "0\(Int(stopwatch.counter / 60))"
        }
        var seconds: String = String.init(format: "%.2f", stopwatch.counter.truncatingRemainder(dividingBy: 60))
        if stopwatch.counter.truncatingRemainder(dividingBy: 60) < 10 {
            seconds = "0" + seconds
        }
        label.text = minutes + ":" + seconds
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Counter Info"
    }
}

extension Selector {
    static let updateMainTimer = #selector(ViewController.updateMainTimer)
    static let updateLapTimer = #selector(ViewController.updateLapTimer)
}

