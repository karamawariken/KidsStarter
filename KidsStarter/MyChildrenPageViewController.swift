//
//  MyChildrenPageViewController.swift
//  KidsStarter
//
//  Created by nishi kosei on 2017/06/30.
//  Copyright © 2017年 nishi kosei. All rights reserved.
//

import UIKit
import Alamofire
class MyChildrenPageViewController: UIViewController,UITableViewDelegate {
    //jsonデータ用NSDictionary
    var jsonparse1: NSDictionary!
    var jsonparse2: NSDictionary!
    var products: NSArray!
    let apiUrl = "http://192.168.0.4:3000/api/v1/products/draft/1"
    let headers: HTTPHeaders = [
        "Uid": String(describing: UserDefaults.standard.string(forKey: "Uid") as! String),
        "Access-Token": String(describing: UserDefaults.standard.string(forKey: "Access-Token") as! String),
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Alamofire.request(apiUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON {response in
            self.jsonparse1 = response.result.value as! NSDictionary
            self.jsonparse2 = self.jsonparse1["data"] as! NSDictionary
            self.products = self.jsonparse2["products"] as! NSArray
        }
        if (UserDefaults.standard.string(forKey: "Player") == "adult"){
            
        } else if (UserDefaults.standard.string(forKey: "Player") == "child"){
            
        }
        var i = 0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
            if (self.products != nil){
                for elm in self.products{
                    let product_data = elm as? NSDictionary
                    if product_data?["title"] as? String != nil{
                        let button = UIButton()
                        button.setTitle(product_data?["title"] as? String, for: .normal)
                        button.setTitleColor(UIColor.blue, for: .normal)
                        button.addTarget(self, action: #selector(self.buttonEvent(sender:)), for: .touchUpInside)
                        button.sizeToFit()
                        button.tag = product_data?["id"] as! Int
                        button.center = self.view.center
                        button.frame.origin.y = button.frame.origin.y + CGFloat(50 * i)
                        self.view.addSubview(button)
                    }
                    i += 1
                }
            }
        }
        
    }
    
    func buttonEvent(sender: UIButton) {
        let product_id = sender.tag
        var publicChangeApiUrl = "http://192.168.0.4:3000/api/v1/products/draft/change/\(product_id)"
        Alamofire.request(publicChangeApiUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON {response in
            print(response.result.value as! NSDictionary)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
