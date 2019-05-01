//
//  GoalsViewController.swift
//  nutritionapp
//
//  Created by Anna-Maria Andreeva on 4/26/19.
//  Copyright © 2019 Yun, Yeji. All rights reserved.
//

import UIKit

class GoalsViewController: UIViewController {

    @IBOutlet weak var calorieGoal: UITextField!
    @IBOutlet weak var stepGoal: UITextField!
    @IBOutlet weak var waterGoal: UITextField!
    
    var calorieGoalNum: Int = 0
    var stepGoalNum: Int = 0
    var waterGoalNum: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func saveButton(_ sender: UIButton) {
        self.calorieGoalNum = Int(calorieGoal.text!)!
        self.stepGoalNum = Int(stepGoal.text!)!
        self.waterGoalNum = Int(waterGoal.text!)!
        let vc = ViewController()
        vc.waterGoal = waterGoalNum
    }
    
}
