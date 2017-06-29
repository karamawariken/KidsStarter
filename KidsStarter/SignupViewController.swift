//
//  SignupViewController.swift
//  KidsStarter
//
//  Created by nishi kosei on 2017/06/26.
//  Copyright © 2017年 nishi kosei. All rights reserved.
//

import Foundation
import UIKit
import FacebookLogin
import FacebookCore

class SignupViewController: UIViewController{
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var usernameTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    
    @IBAction func signupBtn(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

}
