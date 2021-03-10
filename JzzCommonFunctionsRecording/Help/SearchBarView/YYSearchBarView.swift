//
//  YYSearchBarView.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2021/2/25.
//  Copyright © 2021 蒋状状的mac. All rights reserved.
//

import UIKit

class YYSearchBarView: UIView {

    var contentView = UIView();
    var searchTextField = UITextField();
    var lab_Icon = UILabel();
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.customUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
       
    //自定义UI
    func customUI(){
        self.contentView = UIView.init(frame: self.frame)
        self.addSubview(self.contentView)
        self.searchTextField = UITextField.init(frame: CGRect.init(x: 8, y: 5, width: self.contentView.frame.width - 16, height: self.contentView.frame.height - 10))
        self.contentView.addSubview(self.searchTextField)
        self.lab_Icon = UILabel.init(frame: CGRect.init(x: 12, y: 5, width: self.contentView.frame.height - 10, height: self.contentView.frame.height - 10))
        self.contentView.addSubview(self.lab_Icon)
        
        self.lab_Icon.text = "\u{e600}"
        self.lab_Icon.textAlignment = .center;
        self.lab_Icon.font = UIFont(name: "iconfont", size: 20)
        
        self.lab_Icon.textColor = UIColor.colorWithHex(hexColor: 0xC7C7CD)
    
        self.searchTextField.setValue(NSNumber(value:Int(self.lab_Icon.frame.width)), forKey: "paddingLeft")
        self.searchTextField.font = UIFont.init(name: "PingFang-SC-Medium", size: 17)
        self.searchTextField.textColor = UIColor.colorWithHex(hexColor: 0x333333)
        self.searchTextField.layer.masksToBounds = true
        self.searchTextField.clearButtonMode = .whileEditing
        self.searchTextField.tintColor = UIColor.gray
        self.searchTextField.borderStyle = UITextField.BorderStyle.roundedRect
        self.searchTextField.returnKeyType = .search
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
