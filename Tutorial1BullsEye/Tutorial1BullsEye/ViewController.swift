//
//  ViewController.swift
//  Tutorial1BullsEye
//
//  Created by HuangMing on 2017/9/5.
//  Copyright © 2017年 Fruit. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    
    var currentValue: Int = 0
    var targetValue: Int = 0
    var score = 0
    var round = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let thumbImageNormal = #imageLiteral(resourceName: "target")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "target")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftImage = #imageLiteral(resourceName: "sliderLeft")
        
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "sliderRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        

        startNewGame()
        updateLabels()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func showAlert() {
   
        let difference = abs(currentValue - targetValue)
        var points = 100 - difference
        
        
        let evaluationTitle: String
        if difference == 0 {
            evaluationTitle = "Perfect!"
            points += 100
        } else if difference < 5 {
            evaluationTitle = "Almost had it!"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            evaluationTitle = "Pretty good!"
        } else {
            evaluationTitle = "Not even close..."
        }
        score += points
        
        let meaasage = "Your scored is: \(score) points"
        let alert = UIAlertController(title: evaluationTitle, message: meaasage, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.startNewRound()
            self.updateLabels()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func moveSlider(_ slider: UISlider) {
        print("The value of the slider is now : \(slider.value)")
        currentValue = lroundf(slider.value)
        
    }
    func startNewRound() {
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
    }
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    @IBAction func startOver(_ button: UIButton) {
        startNewGame()
        updateLabels()
        
        //Animation transitionFade
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        view.layer.add(transition, forKey: nil)
    }
    func startNewGame() {
        round = 0
        score = 0
        startNewRound()
    }

}

