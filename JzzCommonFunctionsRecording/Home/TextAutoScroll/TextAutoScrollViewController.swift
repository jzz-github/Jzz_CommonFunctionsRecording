//
//  TextAutoScrollViewController.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2021/1/29.
//  Copyright © 2021 蒋状状的mac. All rights reserved.
//

import UIKit

class TextAutoScrollViewController: BaseViewController {

    var label: AutoHorizontalScrollView?
    
    var verticalView: AutoVerticalScrollView?
    
    override func viewDidAppear(_ animated: Bool) {
        label?.scrollIt()
        verticalView?.startScroll()

    }

    override func viewWillDisappear(_ animated: Bool) {
        verticalView?.stopScroll()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label = AutoHorizontalScrollView.init(frame: CGRect(x: 20.0, y: 80.0, width: KSCREEN_WIDTH - 40, height: 30.0))
        label?.text = "Hi Mom!  How are you?  I really ought to write more often."
        label?.textColor = .white
        label?.font = UIFont.init(name: "PingFang-SC-Medium", size: 14)
        label?.backgroundColor = UIColor.colorWithHex(hexColor: 0xBF8F00)
        label?.layer.cornerRadius = 15
        self.view.addSubview(label!)
        
        
        verticalView = .init(frame: CGRect(x: 20.0, y: 200.0, width: 300.0, height: 30.0))
        verticalView?.textDataSource = ["今天是一个好天气","温度达到了30度以上","可是我并没有感觉很热","因为什么呢","公司开空调了","这个是不是可以有啊"]
        verticalView?.textColor = .white
        verticalView?.textFont = UIFont.systemFont(ofSize: 20)
        verticalView?.backgroundColor = UIColor.colorWithHex(hexColor: 0xBF8F00)
        verticalView?.layer.cornerRadius = 15
        self.view.addSubview(verticalView!)
        
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
