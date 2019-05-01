//
//  WaterViewController.swift
//  nutritionapp
//
//  Created by Minguell, Tomas P on 4/26/19.
//  Copyright © 2019 Yun, Yeji. All rights reserved.
//

import UIKit

class WaterViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var waterView: WaterView!
    @IBOutlet weak var vc: ViewController!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pushButtonPressed(_ button: WaterButton) {
        if button.isAddButton {
            waterView.counter += 1
            vc.counter += 1
        } else {
            if waterView.counter > 0 {
                waterView.counter -= 1
                vc.counter -= 1
            }
        }
    }
}
