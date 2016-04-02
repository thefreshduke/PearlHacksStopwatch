//
//  ViewController.swift
//  PearlHacks2016Stopwatch
//
//  Created by Scotty Shaw on 4/1/16.
//  Copyright © 2016 ___sks6___. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer = NSTimer()
    var startTime = NSTimeInterval()
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var stopwatchButton: UIButton!
    
    @IBAction func toggleStopwatchOnAndOff(sender: AnyObject) {
        
        // start the timer
        if (!timer.valid) {
            
            // toggle button title
            stopwatchButton.setTitle("STOP", forState: .Normal)
            
            // validate timer
            let repeatingFunction: Selector = "updateTime"
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: repeatingFunction, userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate()
            
            // toggle activity indicator view animation
            activityIndicatorView.startAnimating()
        }
        
        // stop the timer
        else {
            
            // toggle button title
            stopwatchButton.setTitle("START", forState: .Normal)
            
            // invalidate timer
            timer.invalidate()
            
            // toggle activity indicator view animation
            activityIndicatorView.stopAnimating()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        adjustTimeLabelTextColor(slider)
        switchBackgroundColor(switcher)
        updateProgressView(0.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateTime() {
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        // calculate elapsed time
        var elapsedTime = currentTime - startTime
        
        updateProgressView(elapsedTime)
        
        // calculate elapsed minutes
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= NSTimeInterval(minutes) * 60.0
        
        // calculate elapsed seconds
        let seconds = UInt8(elapsedTime)
        elapsedTime -= NSTimeInterval(seconds)
        
        // calculate elasped milliseconds
        let milliseconds = UInt8(elapsedTime * 100)
        
        // add the leading zero for minutes, seconds and milliseconds and store them as string constants
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strMilliseconds = String(format: "%02d", milliseconds)
        
        // concatenate minutes, seconds and milliseconds and assign them to the UILabel
        timeLabel.text = "\(strMinutes):\(strSeconds):\(strMilliseconds)"
    }
    
    // extra storyboard elements
    
    // slider
    @IBOutlet weak var slider: UISlider!
    
    var sliderValue: CGFloat!
    
    @IBAction func adjustTimeLabelTextColor(sender: AnyObject) {
        sliderValue = CGFloat(slider.value)
        timeLabel.textColor = UIColor(red: sliderValue, green: sliderValue / 2.0, blue: sliderValue / 1.5, alpha: 1.0)
    }
    
    // switch
    
    @IBOutlet weak var switcher: UISwitch!
    
    @IBAction func switchBackgroundColor(sender: AnyObject) {
        if (switcher.on) {
            self.view.backgroundColor = UIColor.yellowColor()
        }
        else {
            self.view.backgroundColor = UIColor.whiteColor()
        }
    }
    
    // activity indicator view
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    // progress view
    
    @IBOutlet weak var progressView: UIProgressView!
    
    func updateProgressView(elapsedTime: NSTimeInterval) {
        let completedProgress = Float(elapsedTime) / 10.0
        let isProgressViewAnimated = (elapsedTime != 0)
    
        progressView.setProgress(completedProgress, animated: isProgressViewAnimated)
    }

    

}

