//
//  ViewController.swift
//  BullsEye
//
//  Created by 田冰 on 9/22/18.
//  Copyright © 2018 tianbing. All rights reserved.
//

import UIKit
import QuartzCore


class ViewController: UIViewController {
    var currentValue: Int = 0
    var targetValue: Int = 0
    var scores = 0
    var round = 0
    
    
    func updateLables() {
        targetLable.text = String(targetValue)
        scoreLable.text = String(scores)
        roundLable.text = String(round)
    }
    func startNewRound() {
        targetValue = 1+Int(arc4random_uniform(100))
        currentValue=50
        slider.value=Float(currentValue)
        print(targetValue)
        updateLables()
    }
    @IBAction func startOver() {
        scores = 0
        round = 0
        startNewRound()
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        view.layer.add(transition, forKey: nil)
        
    }
    //为什么没有先运行startOver（），func和@IBAction区别？
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLable: UILabel!
    @IBOutlet weak var scoreLable: UILabel!
    @IBOutlet weak var roundLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startOver()
        let thumbImageNormal = UIImage(named: "SliderThumb")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        let thumbImageHighlighted = UIImage(named: "Thumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftImage = UIImage(named: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage?.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        let trackRightImage = UIImage(named: "SliderTrackRight")
        let trackRightResizable = trackRightImage?.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert() {
        let difference = abs(currentValue - targetValue)
        var points = 100 - difference
        
        if points == 100 {
            title = "perfect! you got a bonus of 100 points!"
            points += 100
        } else if points > 80 {
            title = "you almost got it!"
            if difference < 5 {
                points += 50
            }
        } else {
            title = "miss out"
        }
        scores += points
        let alert = UIAlertController (title: title, message: "Your score is:  \(points)" + " \n You scored \(scores)", preferredStyle: .alert)
        let action = UIAlertAction (title: "OK", style: .default, handler: {action in self.startNewRound()})
        alert.addAction(action)
        present(alert, animated: false, completion: nil)
        round += 1
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
        print(currentValue)
    }
}

