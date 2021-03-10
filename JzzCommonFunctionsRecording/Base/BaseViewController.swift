//
//  BaseViewController.swift
//  yktIcve
//  公共
//  Created by cc on 2018/9/13.
//  Copyright © 2018年 zqyou. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    var toolBar = UIToolbar();
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.modalPresentationStyle = .fullScreen

//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //修改导航栏文字字体和大小
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 28)]
        //修改导航栏文字颜色
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        ///导航栏背景颜色
        self.navigationController?.navigationBar.barTintColor = UIColor.white

        //关闭侧滑返回
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
