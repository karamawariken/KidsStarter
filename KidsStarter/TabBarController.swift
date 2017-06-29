//
//  TabBarController.swift
//  KidsStarter
//
//  Created by nishi kosei on 2017/06/30.
//  Copyright © 2017年 nishi kosei. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    
    /*required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //tabbarの更新
        var viewControllers: [UIViewController] = []
        let player: String = UserDefaults.standard.string(forKey: "Player") as! String
        
        //homeはどちらとも見える
        let firstSB = UIStoryboard(name: "Main", bundle: nil)
        let firstViewController = firstSB.instantiateViewController(withIdentifier: "home")
        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.mostRecent, tag: 1)
        viewControllers.append(firstViewController)


        if(player == "adult"){
            let firstSB1 = UIStoryboard(name: "Main", bundle: nil)
            let secondViewController = firstSB1.instantiateViewController(withIdentifier: "my_child_page")
            secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.mostViewed, tag: 2)
            viewControllers.append(secondViewController)
        } else if(player == "child"){
            let firstSB1 = UIStoryboard(name: "Main", bundle: nil)
            let secondViewController = firstSB1.instantiateViewController(withIdentifier: "make_product")
            secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.mostViewed, tag: 2)
            viewControllers.append(secondViewController)
            
        }

        let firstSB2 = UIStoryboard(name: "Main", bundle: nil)
        let userPageViewController = firstSB2.instantiateViewController(withIdentifier: "user_page")
        userPageViewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.contacts, tag: 3)
        viewControllers.append(userPageViewController)

        
        let firstSB3 = UIStoryboard(name: "Main", bundle: nil)
        let SwitchUserViewController = firstSB3.instantiateViewController(withIdentifier: "switch_user_page")
        SwitchUserViewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.contacts, tag: 4)
        viewControllers.append(SwitchUserViewController)
        
        
        self.setViewControllers(viewControllers, animated: false)
        
        
        // なぜか0だけだと選択されないので1にしてから0に
        self.selectedIndex = 1
        self.selectedIndex = 0
        
        
    }*/
    override func viewDidLoad() {
        super.viewDidLoad()
        test()
    }
    func test(){
        //tabbarの更新
        var viewControllers: [UIViewController] = []
        var player: String = UserDefaults.standard.string(forKey: "Player") as! String
        
        //homeはどちらとも見える
        let firstSB = UIStoryboard(name: "Main", bundle: nil)
        let firstViewController = firstSB.instantiateViewController(withIdentifier: "home")
        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.mostRecent, tag: 1)
        viewControllers.append(firstViewController)
        
        
        if(player == "adult"){
            let firstSB1 = UIStoryboard(name: "Main", bundle: nil)
            let secondViewController = firstSB1.instantiateViewController(withIdentifier: "my_child_page")
            secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.bookmarks, tag: 2)
            viewControllers.append(secondViewController)
            print("adult")

        } else if(player == "child"){
            let firstSB1 = UIStoryboard(name: "Main", bundle: nil)
            let secondViewController = firstSB1.instantiateViewController(withIdentifier: "make_product")
            secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.mostViewed, tag: 2)
            viewControllers.append(secondViewController)
            print("child")            
        }
        
        let firstSB2 = UIStoryboard(name: "Main", bundle: nil)
        let userPageViewController = firstSB2.instantiateViewController(withIdentifier: "user_page")
        userPageViewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.contacts, tag: 3)
        viewControllers.append(userPageViewController)
        
        
        let firstSB3 = UIStoryboard(name: "Switch", bundle: nil)
        let SwitchUserViewController = firstSB3.instantiateViewController(withIdentifier: "switch_user_page")
        SwitchUserViewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.contacts, tag: 4)
        viewControllers.append(SwitchUserViewController)
        
        
        self.setViewControllers(viewControllers, animated: false)
        
        
        // なぜか0だけだと選択されないので1にしてから0に
        self.selectedIndex = 1
        self.selectedIndex = 0

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
