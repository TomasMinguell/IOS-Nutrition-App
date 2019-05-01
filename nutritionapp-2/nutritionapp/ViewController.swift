//
//  ViewController.swift
//  nutritionapp
//
//  Created by Yun, Yeji on 4/22/19.
//  Copyright © 2019 Yun, Yeji. All rights reserved.
//

import UIKit

let goal = GoalsViewController()

class ViewController: UIViewController {

    @IBOutlet weak var waterLabel: UILabel!
    
    @IBInspectable var counter: Int = 0
    @IBInspectable var waterGoal = goal.waterGoalNum
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.waterLabel.text = "\(String(counter)) of \(String(waterGoal)) glasses of water drunk"

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

