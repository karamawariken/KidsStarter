//
//  FirstViewController.swift
//  KidsStarter
//
//  Created by nishi kosei on 2017/06/13.
//  Copyright © 2017年 nishi kosei. All rights reserved.
//

import UIKit
import Alamofire

class FirstViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    // ステータスバーの高さ
    let statusBarHeight = UIApplication.shared.statusBarFrame.height + 32
    //jsonデータ用NSDictionary
    var jsonparse1: NSDictionary!
    var jsonparse2: NSDictionary!
    var products: NSArray!
    let apiUrl = "http://192.168.0.4:3000/api/v1/products/search"
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
        
        
        let tableView = UITableView()
        tableView.frame = CGRect(
            x: 0,
            y: statusBarHeight,
            width: self.view.frame.width,
            height: self.view.frame.height - statusBarHeight
        )
        //Delegate設定
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /// セルの個数を指定するデリゲートメソッド（必須）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    /// セルに値を設定するデータソースメソッド（必須）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.accessoryType = .detailButton
        var i = 0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(3)) {
            if (self.products != nil){
                for elm in self.products{
                    if (indexPath.row == i)  {
                        let product_data = elm as? NSDictionary
                        if product_data?["title"] as? String != nil{
                            cell.textLabel?.text = product_data?["title"] as? String
                        }
                        if product_data?["username"] as? String != nil{
                            cell.detailTextLabel?.text = product_data?["username"] as? String
                        }
                    }
                    i += 1
                }
            }
        }
        return cell
    }


}

