//
//  DateTimePickerView.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2020/12/4.
//  Copyright © 2020 蒋状状的mac. All rights reserved.
//

import UIKit
import SnapKit
import LXDateTimePicker

@objc protocol DateTimePickerViewDelegate: NSObjectProtocol{

    @objc optional func returnDataDelegate(selectData:String)

}

class DateTimePickerView: UIView {

    weak var delegate: DateTimePickerViewDelegate?
    
    override init(frame: CGRect) { 
        super.init(frame: frame)
        self.backgroundColor = UIColor(hex:"#000000").alpha(0.4)
        self.setUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc private func setUI(){
        
        self.addSubview(pickerBgView)
        
        self.pickerBgView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(300)
        }
        
        self.pickerBgView.addSubview(self.cancelBtn)
        
        self.cancelBtn.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(10)
            make.width.equalTo(60)
            make.height.equalTo(20)
        }
        
        self.pickerBgView.addSubview(self.determineBtn)
        
        self.determineBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.top.equalTo(10)
            make.width.equalTo(60)
            make.height.equalTo(20)
        }
        
        self.pickerBgView.addSubview(picker)
        
        self.picker.snp.makeConstraints { (make) in
            make.left.right.equalTo(10)
            make.bottom.equalTo(-20)
            make.top.equalTo(30)
        }
        
    }

    /**
     代理方法
     */
    
    @objc func returnData(){
    
        let dateComponents = picker.dateComponents
        let date = dateComponents.date
        print(date, formatter.string(from: date))
        print(dateComponents)
        
        if self.delegate!.responds(to: #selector(DateTimePickerViewDelegate.returnDataDelegate)){
            self.delegate!.returnDataDelegate?(selectData: formatter.string(from: date))
        }
        self.hideView()
    }
    
    /**
    点击其他位置 视图移除
    */
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.hideView()
    }
    
    /**
    视图隐藏显示
    */
    
    func showView(){
    UIApplication.shared.windows.filter({ $0.isKeyWindow }).last?.addSubview(self)
        self.frame = CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: KSCREEN_HEIGHT)
    }
    
    
    @objc private func hideView(){
        self.removeFromSuperview()
    }

    /**
     INIT
     */

    private let picker = DateTimePicker { (config) in
    /*
        config.mode = .year
        config.mode = .month
        config.mode = .yearMonth
        config.mode = .hourMinute
        config.mode = .yearMonthDay
        config.mode = .yearMonthDayHourMinute
         */
       
        config.mode = .yearMonthDayHourMinute
        config.use12HourClock = true
        config.language = .chinese
    }
    
    private let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd HH:mm"
        return f
    }()
    
    
    private lazy var cancelBtn:UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.white
        btn.setTitle("取消", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = UIFont.init(name: "HelveticaNeue-Light", size: 15)
        btn.titleLabel?.textAlignment = .center
        btn.addTarget(self, action: #selector(self.hideView), for: .touchUpInside)
        return btn
    }()
    
    private lazy var determineBtn:UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.white
        btn.setTitle("确定", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = UIFont.init(name: "HelveticaNeue-Light", size: 15)
        btn.addTarget(self, action: #selector(self.returnData), for: .touchUpInside)
        btn.titleLabel?.textAlignment = .center
        return btn
    }()
    
    private lazy var pickerBgView :UIView = {
        let view =  UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    

}
