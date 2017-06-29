//
//  SwitchUserViewController.swift
//  KidsStarter
//
//  Created by nishi kosei on 2017/06/30.
//  Copyright © 2017年 nishi kosei. All rights reserved.
//

import UIKit
import Alamofire
class SwitchUserViewController: UIViewController {
    
    //jsonデータ用NSDictionary
    var jsonparse1: NSDictionary!
    var jsonparse2: NSDictionary!
    var products: NSArray!
    let apiUrl = "http://192.168.0.4:3000/api/v1/products/search"
    let headers: HTTPHeaders = [
        "Uid": String(describing: UserDefaults.standard.string(forKey: "Uid") as! String),
        "Access-Token": String(describing: UserDefaults.standard.string(forKey: "Access-Token") as! String),
        ]
    @IBAction func pass_btn1(_ sender: UIButton) {
    }
    @IBAction func pass_btn2(_ sender: UIButton) {
    }
    
    @IBAction func pass_btn3(_ sender: UIButton) {
    }
    
    @IBAction func pass_btn4(_ sender: UIButton) {
    }
    
    @IBAction func pass_btn5(_ sender: UIButton) {
    }
    
    @IBAction func pass_btn6(_ sender: UIButton) {
    }

    @IBAction func pass_btn7(_ sender: UIButton) {
    }
    
    @IBAction func pass_btn8(_ sender: UIButton) {
        
    }
    @IBAction func switch_btn(_ sender: UIButton) {
        if (UserDefaults.standard.string(forKey: "Player") == "adult"){
            UserDefaults.standard.set("child", forKey: "Player")
        } else if (UserDefaults.standard.string(forKey: "Player") == "child"){
            UserDefaults.standard.set("adult", forKey: "Player")
        }
        //切り替え後もう一度、tabbarcontrollerを呼びだす
        let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let firstView = mainStoryboard.instantiateInitialViewController()
        self.present(firstView!, animated: true,completion: nil)
    }
    
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
        

        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
