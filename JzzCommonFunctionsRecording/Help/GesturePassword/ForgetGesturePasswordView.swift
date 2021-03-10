//
//  ForgetGesturePasswordView.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2021/1/28.
//  Copyright © 2021 蒋状状的mac. All rights reserved.
//

import UIKit

class ForgetGesturePasswordView: UIView {

    //是否显示指纹解锁
    var isShowIDunlock : Bool = false{
        didSet{
    
            forgetPsdButton.removeFromSuperview()
                addSubview(forgetPsdButton)
            
            forgetPsdButton.frame = CGRect(x: (kScreenW - SP6(x: 120))/2, y: 0, width: SP6(x: 120), height: self.frame.size.height)
                forgetPsdButton.contentHorizontalAlignment = .center
        }
    }
    //忘记手势密码
    lazy var forgetPsdButton : UIButton = {
        let forgetPsdButton : UIButton = UIButton()
     
      forgetPsdButton.setTitle("忘记手势密码", for: .normal)
      forgetPsdButton.setTitleColor(UIColor.colorWithHex(hexColor: 0xb4bbca), for: .normal)
      forgetPsdButton.titleLabel?.font = UIFont.systemFont(ofSize: SP6(x: 15))
        return forgetPsdButton
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



