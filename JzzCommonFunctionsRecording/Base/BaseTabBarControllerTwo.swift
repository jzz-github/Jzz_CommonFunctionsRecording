//
//  BaseTabBarControllerTwo.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2020/12/2.
//  Copyright © 2020 蒋状状的mac. All rights reserved.
//

import UIKit

class BaseTabBarControllerTwo: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let homeVC = HomeViewController()
        homeVC.tabBarItem.image = UIImage(named: "home")
        homeVC.tabBarItem.selectedImage =  UIImage(named: "home_1")?.withRenderingMode(.alwaysOriginal)
        homeVC.tabBarItem.title = "首页"
        homeVC.tabBarItem.setTitleTextAttributes([.foregroundColor:UIColor.black], for: .selected)
        let navigationHomeVC = UINavigationController(rootViewController: homeVC)
        self.addChild(navigationHomeVC)
        
        let mineVC = MineViewController()
        mineVC.tabBarItem.image =  UIImage(named: "me")
        mineVC.tabBarItem.selectedImage =  UIImage(named: "me_1")?.withRenderingMode(.alwaysOriginal)
        mineVC.tabBarItem.title = "我的"
        mineVC.tabBarItem.setTitleTextAttributes([.foregroundColor:UIColor.black], for: .selected)
        let navigationMineVC = UINavigationController(rootViewController: mineVC)

        self.addChild(navigationMineVC)
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
