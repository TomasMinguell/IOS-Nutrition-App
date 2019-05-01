//
//  FoodData.swift
//  nutritionapp
//
//  Created by Anna-Maria Andreeva on 4/26/19.
//  Copyright © 2019 Yun, Yeji. All rights reserved.
//

import UIKit
import Foundation

protocol FoodDataProtocol
{
    func responseDataHandler(data:NSDictionary)
    func responseError(message:String)
}

class FoodData {
    private let urlSession = URLSession.shared
    private var dataTask:URLSessionDataTask? = nil
    var result = [Food] ()
    private var _group:DispatchGroup = DispatchGroup()
    
    var group:DispatchGroup {
        get {return _group}
        set (newgroup) {_group = newgroup}
    }
    
    var delegate:FoodDataProtocol? = nil
    
    init(group: DispatchGroup) {
        self.group = group
    }
    //MARK : get data from API
    //first part to get food number, using keyword for user input
    func searchData (withSearch search:String){
        let base = "https://api.nal.usda.gov/ndb/search/?format=json&q="
        let urlPath = base + search + "&sort=r&max=25&api_key=8xqhEvNRGVoTehLPC1LKxUVLuCOlnI9rdkUGMy9N"
        print (urlPath)
        let url:NSURL? = NSURL(string: urlPath)
        let dataTask = self.urlSession.dataTask(with: url! as URL) { (data, response, error) -> Void in
            if let data = data {
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        print("json worked")
                        if let list = json["list"] as? NSDictionary {
                            print("dataelement worked")
                            //                            print(dataelement)
                            let item = list["item"] as? NSMutableArray
                            //catch invalid response
                            if item == nil {self.delegate?.responseError(message: "data not found")
                                print("we got an error")
                                self.group.leave()
                            }
                            else{
//                                print (item!)
                                let count = item!.count
                                for i in 0...count-1 {
                                    let info = ((item![i]) as? NSDictionary)
                                    if info != nil {
                                        let name = ((info)!.value(forKey: "name") as! NSString)
                                        var name_array: [String] = name.components(separatedBy: ", ")
                                        name_array.popLast()
                                        let objectname = name_array[0]
                                        var objectinfo = ""
                                        if name_array.count > 1{
                                            objectinfo = name_array[1]
                                        }
                                        let number = info!.value(forKey: "ndbno") as!NSString
                                        self.result.append(Food(name: objectname, info: objectinfo, calorie: 0))
                                        self.reportData(withNumber: number as String, index: i)
                                        //print (name)
                                        //CHANGE to viewcontroller selected cell
                                        //let number = info!.value(forKey: "ndbno") as!NSString
                                        //print(number)
                                    }
                                    else {
                                        self.delegate?.responseError(message: "data not found")
                                        print("we got an error")
                                        self.group.leave()
                                    }
                                }
                                self.group.leave()
                            }
                        }
                    }
                }
                    //invalid infos and input
                catch{
                    self.delegate?.responseError(message: "data not found")
                    print("we got an error")
                    self.group.leave()
                }
                
            }
        }
        dataTask.resume()
    }
    
    func reportData (withNumber number:String, index ind:Int) {
        let base = "https://api.nal.usda.gov/ndb/reports/?ndbno="
        let urlPath = base + number + "&type=b&format=json&api_key=8xqhEvNRGVoTehLPC1LKxUVLuCOlnI9rdkUGMy9N"
        print (urlPath)
        let url:NSURL? = NSURL(string: urlPath)
        let dataTask = self.urlSession.dataTask(with: url! as URL) { (data, response, error) -> Void in
            if let data = data {
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        print("json worked")
                        if let report = json["report"] as? NSDictionary {
                            print("dataelement worked")
                            //                            print(dataelement)
                            let food = report["food"] as? NSDictionary
                            print("food worked")
                            //catch invalid response
                            if food == nil {self.delegate?.responseError(message: "data not found")
                                print("we got an error")}
                            else{
                                let nutrients = food!["nutrients"] as? NSMutableArray
                                print("nutrients worked")
                                if nutrients != nil {
                                    let nuts = nutrients!.count
                                    for i in 0...nuts-1{
                                        let en = nutrients![i] as! NSDictionary
                                            if en.value(forKey: "name") as! NSString == "Energy"{
                                                print("yay")
                                                let energy = nutrients![i] as! NSDictionary
                                                print("energy worked")
                                                let calories = energy.value(forKey: "value") as! NSString
                                                print(calories)
                                                let cal = calories.integerValue
                                                self.result[ind].calorie = cal
                                                }
                                                
                                            else{
                                                continue
                                        }
                                    }


                                }
                                
                                else {
                                    self.delegate?.responseError(message: "data not found")
                                    print("we got an error")
                                    
                                }
                                
                            }
                                }
                            }
                        }
                    
            
                    //invalid infos and input
                catch{
                    self.delegate?.responseError(message: "data not found")
                    print("we got an error")
                }
                
            }
        }
        dataTask.resume()
    }
}
