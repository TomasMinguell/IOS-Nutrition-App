//
//  FoodViewController.swift
//  nutritionapp
//
//  Created by Yun, Yeji on 4/26/19.
//  Copyright © 2019 Yun, Yeji. All rights reserved.
//

import UIKit
var searchText = ""
var number = ""

class FoodViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    var foods = [Food] ()

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!

//    @IBAction func unwind: (UIStoryboardSegue){
//        
//    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        let group = DispatchGroup()
        group.enter()
        let dataSession = FoodData(group:group)
        searchText = searchTextField!.text!
        dataSession.result = []
        if searchText == ""{
            return
        }
        else {
            print("hi")
            DispatchQueue.main.async {
                dataSession.searchData(withSearch: searchText)
            }
            
            group.notify(queue: .main) {
                sleep(1)
                self.foods = dataSession.result
                self.tableView.reloadData()
            }
            
//            self.dataSession.reportData(withNumber: number)
        }
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let food:Food
        food = foods[indexPath.row]
        cell.textLabel!.text = food.name
        cell.detailTextLabel!.text = food.info
        let cellTitleLabel = UILabel(frame: CGRect(x: 300,y: 13,width: 100,height: 20))
        cellTitleLabel.textAlignment = NSTextAlignment.right
        cellTitleLabel.textColor = UIColor.black
        cellTitleLabel.text = String(food.calorie)
        cellTitleLabel.font = UIFont(name: "Swiss721BT-Roman", size: 16)
        cell.addSubview(cellTitleLabel)
        
        return cell
    }
    

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
