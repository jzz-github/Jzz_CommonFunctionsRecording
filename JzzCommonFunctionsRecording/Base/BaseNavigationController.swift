//
//  BaseNavigationController.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2020/11/27.
//  Copyright © 2020 蒋状状的mac. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController,UINavigationControllerDelegate {

    var popDelegate:UIGestureRecognizerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.isTranslucent = false;
        
        self.popDelegate = self.interactivePopGestureRecognizer?.delegate
        
        self.delegate = self
    }
    
    //MARK: - UIGestureRecognizerDelegate代理
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        //实现滑动返回的功能
        //清空滑动返回手势的代理就可以实现
        if viewController == self.viewControllers[0] {
            self.interactivePopGestureRecognizer?.delegate = self.popDelegate
        } else {
            self.interactivePopGestureRecognizer?.delegate = nil;
        }
    }
    //拦截跳转事件
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {

        if self.children.count > 0 {
            
            viewController.hidesBottomBarWhenPushed = true
            
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "back")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftClick))
        }
            super.pushViewController(viewController, animated: animated)
    }
    
    
    //返回上一层控制器
    @objc func leftClick()  {
        popViewController(animated: true)
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
