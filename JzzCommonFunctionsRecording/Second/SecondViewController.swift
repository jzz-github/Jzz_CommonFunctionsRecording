//
//  SecondViewController.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2020/11/27.
//  Copyright © 2020 蒋状状的mac. All rights reserved.
//

/**
 pod 'SideMenu'
 侧滑第三方库
 */

import UIKit
import SideMenu
class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
    
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        
        let buttonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "header"), style: .plain, target: self, action: #selector(leftBtnAction))
        buttonItem.imageInsets = UIEdgeInsets(top: 0, left: -6, bottom: 0, right: 0)
        self.navigationItem.leftBarButtonItem = buttonItem
        
        let buttonItem2: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "mqz_nav_add"), style: .plain, target: self, action: #selector(rightBtnAction))
        buttonItem2.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -6)
        self.navigationItem.rightBarButtonItem = buttonItem2
        
        self.view.addSubview(self.btn_submit)
        
        self.btn_submit.snp.makeConstraints { (make) in
            make.width.equalTo(KSCREEN_WIDTH)
            make.height.equalTo(40)
            make.center.equalToSuperview()
        }
        // Do any additional setup after loading the view.
        
        // 定义一个侧栏菜单
        let menu = SideMenuNavigationController(rootViewController: SideMenuViewController())
        //侧栏菜单不显示导航栏
        menu.isNavigationBarHidden = true
        //将侧栏宽度设置为屏幕宽度的一半
        menu.menuWidth = round(min(KSCREEN_WIDTH, KSCREEN_HEIGHT) * 0.7)
        // 新视图进来时，菜单不自动隐藏
        menu.dismissOnPush = false
        // 新视图进来时，菜单隐藏过程由动画效果
        menu.alwaysAnimate = true
        // 默认情况下，展开动画播放时间为 0.35 秒
        menu.presentDuration = 1

//        // 将侧栏菜单初始时尺寸为正常值的一半
//        menu.presentationStyle.menuScaleFactor = 0.5
        //侧滑页面初始透明度
        menu.presentationStyle.menuStartAlpha = 0.7
        //主页面侧滑结束透明度
        menu.presentationStyle.presentingEndAlpha = 1
        
        // 动画过程的背景色
//        menu.presentationStyle.backgroundColor = UIColor.white
        
        // 将其作为默认的左侧菜单
        SideMenuManager.default.leftMenuNavigationController = menu
        // 开启通过边缘滑动打开侧栏菜单的功能
        SideMenuManager.default.addPanGestureToPresent(toView:
            self.navigationController!.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView:
            self.navigationController!.view)
           

    }
    
    @objc func leftBtnAction() {
        self.present(SideMenuManager.default.leftMenuNavigationController!, animated: true,
                        completion: nil)
    }
    
    @objc func rightBtnAction() {
        
    }

    
    @objc func detail(){
    
        let vc = SecondDetailsViewController()
    
        self.navigationController?.pushViewController(vc, animated: true)
    
    
    }
    
    
    lazy var btn_submit : UIButton = {
        let btn = UIButton()
        btn.setTitle("tableView刷新和无数据状态占位视图", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(self.detail), for: .touchUpInside)
        return btn
    }()
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//extension SecondViewController: SideMenuNavigationControllerDelegate {
//
//    // 侧栏菜单将要显示时触发
//    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
//        print("菜单将要显示! (是否有动画: \(animated))")
//    }
//
//    // 侧栏菜单显示完毕时触发
//    func sideMenuDidAppear(menu: SideMenuNavigationController, animated: Bool) {
//        print("菜单显示完成! (是否有动画: \(animated))")
//    }
//
//    // 侧栏菜单将要隐藏时触发
//    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
//        print("菜单将要隐藏!(是否有动画: \(animated))")
//    }
//
//    // 侧栏菜单隐藏完毕时触发
//    func sideMenuDidDisappear(menu: SideMenuNavigationController, animated: Bool) {
//        print("菜单隐藏完毕!(是否有动画: \(animated))")
//    }
//}
