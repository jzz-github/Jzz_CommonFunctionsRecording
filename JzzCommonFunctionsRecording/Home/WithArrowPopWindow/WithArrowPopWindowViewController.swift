//
//  WithArrowPopWindowViewController.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2021/1/21.
//  Copyright © 2021 蒋状状的mac. All rights reserved.
//

/**
 *
 *使用方法 :pod 'SwiftPopMenu'
 *带箭头的弹框,不需传入箭头方向,只需传入箭头位置
 */


import UIKit
import SwiftPopMenu
import MCToast

class WithArrowPopWindowViewController: BaseViewController {

    var popMenu:SwiftPopMenu!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func clickBtn(_ sender: UIButton) {
        /**
         带箭头的弹框,不需传入箭头方向,只需传入箭头位置
         */
        //数据源（icon可不填）
        let popData = [(icon:"me",title:"扫一扫"),
                       (icon:"me_1",title:"分享"),
                       (icon:"home",title:"个人资料"),
                       (icon:"home_1",title:"积分兑换")]
        
        //设置参数
        let parameters:[SwiftPopMenuConfigure] = [
            .PopMenuTextColor(UIColor.black),
            .popMenuItemHeight(44),
            .PopMenuTextFont(UIFont.systemFont(ofSize: 18)),
            .PopMenuBackgroudColor(UIColor.white),
        ]
        
        //init  (test随机生成点位置，注意：arrow点是基于屏幕的位置)
        popMenu = SwiftPopMenu(menuWidth: 150, arrow: CGPoint(x: sender.center.x, y: sender.center.y+20+navigationHeight), datas: popData,configures: parameters)

        //click
        popMenu.didSelectMenuBlock = { [weak self](index:Int)->Void in
            print("block select \(index)")
            
            MCToast.mc_success("点击了\(index)行")

            self?.popMenu = nil
        }
        //show
        popMenu.show()
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
