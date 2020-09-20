//
//  ViewController.swift
//  Track Timer
//
//  Created by Nabil Ridhwan on 20/9/20.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var timers: Array<Dictionary<String, Any>> = [];

    let calendar = Calendar.current
    @IBOutlet weak var nameOfTimerInput: UITextField!
    @IBOutlet weak var labelSelector: UISegmentedControl!
    @IBOutlet weak var startTimerButtonView: UIButton!
    @IBAction func startTimerButtonAction(_ sender: UIButton) {
        

        if(startTimerButtonView.currentTitle == "Stop Timer"){
            // Stop the timer
            endTimer()
            startTimerButtonView.setTitle("Start Timer", for: .normal)
            startTimerButtonView.backgroundColor = UIColor.systemBlue
            updateLatestTimerViews()
        }else{
            // Start time timer
            startTimer()
            startTimerButtonView.setTitle("Stop Timer", for: .normal)
            startTimerButtonView.backgroundColor = UIColor.systemRed
            
            setOngoingTimerView()
            showLatestTimerView()
        }
        
        // Change title of button to Stop Timer
        print(timers)
    }
    @IBOutlet weak var latestTimerView: UIStackView!
    @IBOutlet weak var displayTimerName: UILabel!
    @IBOutlet weak var latestTimerNameView: UILabel!
    @IBOutlet weak var latestTimerSecondsView: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        hideLatestTimerView()
        self.nameOfTimerInput.delegate = self
    }
    
    func setOngoingTimerView(){
        let currentTimerIndex = timers.endIndex - 1
        
        latestTimerNameView.text = (timers[currentTimerIndex]["name"] as! String)
        latestTimerSecondsView.text = "Ongoing..."
    }
    
    func startTimer(){
        let nameOfTimer = nameOfTimerInput.text!
        let timerLabel = labelSelector.titleForSegment(at: labelSelector.selectedSegmentIndex)!
        
        // Add to timers
        timers.append(["name": nameOfTimer, "label": timerLabel, "timerStart": Date(), "timerEnd": Date()])
    }
    
    func endTimer(){
        // Set the timer end value
        let currentTimerIndex = timers.endIndex - 1
        timers[currentTimerIndex]["timerEnd"] = Date()
        
    }
    
    func updateLatestTimerViews(){
        let currentTimerIndex = timers.endIndex - 1
        let timerStart = timers[currentTimerIndex]["timerStart"]
        let timerEnd = timers[currentTimerIndex]["timerEnd"]
        
        let elapsedSeconds = calendar.dateComponents([.second], from:timerStart as! Date, to: timerEnd as! Date)
        
        latestTimerNameView.text = (timers[currentTimerIndex]["name"] as! String)
        latestTimerSecondsView.text = "Lasted for \(elapsedSeconds.second!) seconds"
    }
    
    func hideLatestTimerView(){
        latestTimerView.alpha = 0.0
    }
    
    func showLatestTimerView(){
        latestTimerView.alpha = 1.0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
            return false
        }
}
