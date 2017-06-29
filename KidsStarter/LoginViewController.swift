//
//  LoginViewController.swift
//  KidsStarter
//
//  Created by nishi kosei on 2017/06/26.
//  Copyright © 2017年 nishi kosei. All rights reserved.
//

import Foundation
import UIKit
import FacebookLogin
import FacebookCore
import Alamofire

class LoginViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    // MARK: - Facebook Login
    func isLoggedInWithFacebook() -> Bool{
        let loggedIn = AccessToken.current != nil
        return loggedIn
    }
    @IBAction func tapFacebookBtn(_ sender: UIButton) {
        LoginManager().logIn([.email], viewController: self, completion: {
            result in
            switch result{
            case let .success( permission, declinePermission, token):
                //print("token:\(token),\(permission),\(declinePermission)")
                //self.signIn(provider: "Facebook", accsesstoken: token.authenticationToken)
                let apiUrl = "http://192.168.0.4:3000/api/v1/auth/sign_in"
                let headers: HTTPHeaders = [
                    "Fb-Access-Token": String(describing: token.authenticationToken),
                    ]
                Alamofire.request(apiUrl, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON {response in
                    //print(response.result.value)
                    let jsonDict = response.result.value as! NSDictionary
                    let userdata = jsonDict["data"] as! NSDictionary
                    //通信用の、uidとacces_tokenを発行する
                    UserDefaults.standard.set(userdata["uid"] as! String, forKey: "Uid")
                    UserDefaults.standard.set(userdata["access_token"] as! String, forKey: "Access-Token")
                    //現在のアプリ利用者playerをこちらのログインでは、大人と認識する
                    //一般 :adult  子ども :child
                    UserDefaults.standard.set("adult", forKey: "Player")
                }
                //TODO: 各ボタンを押した後の処理を別funcで書きたい
                let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
                let firstView = mainStoryboard.instantiateInitialViewController()// as! FirstViewController
                self.present(firstView!, animated: true,completion: nil)
                
            case let .failed(error):
                print("error:\(error)")
            case .cancelled:
                print("cancelled")
            }
        })
        
    }
    
}
