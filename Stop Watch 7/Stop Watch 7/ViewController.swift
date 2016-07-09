//
//  ViewController.swift
//  Stop Watch 7
//
//  Created by Yogesh Verma on 11/01/16.
//  Copyright © 2016 Yogesh Verma. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
 
    var laps:[String] = []
    
    var timer = NSTimer()
    var minutes:Int = 0
    var seconds:Int = 0
    var fractions:Int = 0
    var stopWatchSting:String = ""
    var startStopWatch : Bool = true
    var addlap:Bool = false
    
    
    @IBOutlet weak var stopWatchLabel: UILabel!
    
    
    @IBOutlet weak var lapsTableView: UITableView!
    
    @IBOutlet weak var startStopButton: UIButton!
    
    @IBOutlet weak var lapsResetButton: UIButton!
    

    @IBAction func startStop(sender: AnyObject) {
        
        if startStopWatch == true {
            
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("updateStopWatch"), userInfo: nil, repeats: true)
            
            startStopWatch  = false
            startStopButton.setImage(UIImage(named: "stop.png"), forState: UIControlState.Normal)
            
            lapsResetButton.setImage(UIImage(named: "lap.png"), forState: UIControlState.Normal)
            
            addlap = true
            
        }
        
        else {
            
            timer.invalidate()
            startStopWatch = true
            
            startStopButton.setImage(UIImage(named: "start.png"), forState: UIControlState.Normal)
            
            lapsResetButton.setImage(UIImage(named: "reset.png"), forState: UIControlState.Normal)
            
            addlap = false
            
        }
        
    }
    
    @IBAction func lapReset(sender: AnyObject) {
        
        if addlap == true{
            
            laps.insert(stopWatchSting, atIndex: 0)
            lapsTableView.reloadData()
        }
        
        else{
            lapsResetButton.setImage(UIImage(named: "lap.png"), forState: UIControlState.Normal)
            laps.removeAll(keepCapacity: false)
            lapsTableView.reloadData()
            fractions = 0
            seconds = 0
            minutes = 0
            
            stopWatchSting = "00:00.00"
            stopWatchLabel.text = stopWatchSting
        }
        
        
    }
    
    func updateStopWatch(){
        
        
        fractions += 1
        if fractions == 100{
            seconds += 1
            fractions = 0
        }
        
        if seconds == 60{
            minutes += 1
            seconds = 0
            
        }
        
        let fractionsString = fractions > 9 ? "\(fractions)" : "0\(fractions)"
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        
        let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        
        stopWatchSting = "\(minutesString):\(secondsString).\(fractionsString)"
        
        stopWatchLabel.text = stopWatchSting
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = "Lap \(laps.count-indexPath.row)"
        cell.detailTextLabel?.text = laps[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return laps.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopWatchLabel.text = "00:00:00"
        lapsTableView.delegate = self
        lapsTableView.dataSource = self
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

