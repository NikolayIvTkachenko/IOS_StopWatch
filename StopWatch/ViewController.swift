//
//  ViewController.swift
//  StopWatch
//
//  Created by Nikolay Tkachenko on 06.08.2020.
//  Copyright © 2020 Nikolay Tkachenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    var laps: [String] = []
    
    var timer = Timer()
    var minutes: Int = 0
    var seconds: Int = 0
    var fractions: Int = 0
    
    var stopWatchString: String = ""
    
    var startStopWatch: Bool = true
    var addLap: Bool = false
    
    @IBOutlet weak var stopWatchLabel: UILabel!
    
    @IBOutlet weak var lapsTableView: UITableView!
    
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var lapResetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopWatchLabel.text = "00:00.00"
        lapsTableView.delegate = self
        lapsTableView.dataSource = self
        
        lapsTableView.backgroundColor = UIColor.black
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func startStop(sender: AnyObject) {
        
        if startStopWatch == true {
            
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateStopWatch), userInfo: nil, repeats: true)
            startStopWatch = false
            startStopButton.setBackgroundImage(UIImage(named: "stop.png"), for: UIControl.State.normal)
            lapResetButton.setBackgroundImage(UIImage(named: "lap.png"), for: UIControl.State.normal)
            addLap = true
            
        } else {
            timer.invalidate()
            startStopWatch = true
            startStopButton.setBackgroundImage(UIImage(named: "start.png"), for: UIControl.State.normal)
            lapResetButton.setBackgroundImage(UIImage(named: "reset.png"), for: UIControl.State.normal)
            addLap = false
        }
        
    }
    
    @IBAction func lapReset(sender: AnyObject) {
        
        if addLap == true {
            laps.insert(stopWatchString, at: 0)
            lapsTableView.reloadData()
        } else {
            //lapResetButton.setImage(UIImage(named: "lap.png"), for: UIControl.State.normal)
            lapResetButton.setBackgroundImage(UIImage(named: "lap.png"), for: UIControl.State.normal)
            laps.removeAll(keepingCapacity: false)
            lapsTableView.reloadData()
            fractions = 0
            seconds = 0
            minutes = 0
            stopWatchString = "00:00.00"
            stopWatchLabel.text = stopWatchString
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "Cell")
        
        // Configure the cell
        
        cell.textLabel?.text = "Lap \(laps.count-indexPath.row)"
        cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8470588235)
        cell.detailTextLabel?.text = laps[indexPath.row]
        cell.textLabel?.textColor = UIColor.red
        
        return cell
    }
    
    @objc func updateStopWatch() {
        fractions += 1
        if fractions == 100 {
            seconds += 1
            fractions = 0
        }
        
        if seconds == 60 {
            minutes += 1
            seconds = 0
        }
        
        let fractionsString = fractions > 9 ? "\(fractions)" : "0\(fractions)"
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        
        stopWatchString = "\(minutesString):\(secondsString).\(fractionsString)"
        stopWatchLabel.text = stopWatchString
    }
}

