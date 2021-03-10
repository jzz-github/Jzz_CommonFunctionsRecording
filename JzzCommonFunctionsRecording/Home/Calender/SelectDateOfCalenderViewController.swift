//
//  SelectDateOfCalenderViewController.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2021/1/29.
//  Copyright © 2021 蒋状状的mac. All rights reserved.
//


import UIKit

//设备物理尺寸
let ScreenHeight = UIScreen.main.bounds.size.height
let ScreenWidth = UIScreen.main.bounds.size.width

let ScreenProportion = ScreenWidth / 375

let IS_IPHONE_X: Bool = ScreenHeight == 812 || ScreenHeight == 896 ?true:false

let STATUS_NAV_BAR_Y:CGFloat = IS_IPHONE_X == true ? 88.0 : 64.0

class SelectDateOfCalenderViewController: UIViewController {

    var startDate:Int? = 0
    var endDate:Int? = 0
    
    var startLabel:UILabel!
    var endLabel:UILabel!
    var dayCountLabel:UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        creatUI()
        
    }
    
    func creatUI() {
        
        let btn = UIButton.init(frame: CGRect.init(x: 55, y: 80, width: 110, height: 50))
        btn.setTitle("打开日历", for: .normal)
        btn.setTitleColor(UIColor.colorWithHex(hexColor: 0x8F8F8F), for: .normal)
        btn.backgroundColor = UIColor.white
        btn.layer.borderColor = UIColor.colorWithHex(hexColor: 0xE0E0E0).cgColor
        btn.layer.borderWidth = 1
        btn.addTarget(self, action: #selector(calendarClick), for: .touchUpInside)
        view.addSubview(btn)
        
        startLabel = UILabel.init(frame: CGRect.init(x: 55, y: 180, width: 150, height: 40))
        startLabel.textColor = UIColor.black
        view.addSubview(startLabel)
        
        endLabel = UILabel.init(frame: CGRect.init(x: 55, y: 230, width: 150, height: 40))
        endLabel.textColor = UIColor.black
        view.addSubview(endLabel)
        
        dayCountLabel = UILabel.init(frame: CGRect.init(x: 55, y: 280, width: 150, height: 40))
        dayCountLabel.textColor = UIColor.black
        view.addSubview(dayCountLabel)
        
    }

    @objc func calendarClick() {
        let zg = ZGSectionScalendarViewController()
        zg.limitMonth = 12 * 15
        zg.BeforeTodayCanTouch = false
        zg.afterTodayCanTouch = true
        zg.endDelegate = self
        zg.startDate = startDate
        zg.endDate = endDate
        zg.type = ZGSenctionScalendarType.ZGSenctionScalendarFutureType//默认展示 future
        zg.selectType = ZGSenctionSelectType.ZGSenctionSelectTypeAreaDate//默认区间选择
//        zg.selectType = ZGSenctionSelectType.ZGSenctionSelectTypeOneDate//单天选择
        let nav = UINavigationController.init(rootViewController: zg)
        zg.title = "选择入住日期"
        self.present(nav, animated: true, completion: nil)
    }
}

extension SelectDateOfCalenderViewController:ScalendarProtocol{
    func callBack(beginTime: Int, endTime: Int) {
        // 区间走这个方法
        startDate = beginTime
        endDate = endTime
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        startLabel.text = dateFormatter.string(from: Date.init(timeIntervalSince1970: TimeInterval(beginTime)))
        endLabel.text = endTime > 0 ? dateFormatter.string(from: Date.init(timeIntervalSince1970: TimeInterval(endTime))) : ""
        
        /**
         * - 通过DateManager中的方法 计算选取的天数 day
         */
        let manage = DateManager.dateManager
        let day : Int = manage.distancesFrom(Date.init(timeIntervalSince1970: TimeInterval(beginTime)), to: Date.init(timeIntervalSince1970: TimeInterval(endTime)))
       
        dayCountLabel.text = "共\(day)天"
        print(day)
    }
    
    
    
    
    func onleSelectOneDateCallBack(selectTime: Int) {
        //单独选一个日期走这个方法
        startDate = selectTime
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        startLabel.text = dateFormatter.string(from: Date.init(timeIntervalSince1970: TimeInterval(selectTime)))
    }
    
}
