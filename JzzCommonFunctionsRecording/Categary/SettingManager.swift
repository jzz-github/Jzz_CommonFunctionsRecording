//
//  SettingManager.swift
//  GesturePasswordView
//
//  Created by liuchunchao on 2018/1/10.
//  Copyright © 2018年 hi-wallet. All rights reserved.
//

import UIKit

class SettingManager: NSObject {

    //获取字符串
    class func getStringValueforKey (key : String) ->String {
        let defaults : UserDefaults = UserDefaults.standard
        
        var stringValue : String? = nil
        
        stringValue = defaults.object(forKey: key) as? String
        if stringValue == nil {
            stringValue = ""
        }
        
        return stringValue!
    }
    
    //存入某一个字符串
    class func setStringValueToUserDefault (stringValue : String,key : String) {
        let defaults : UserDefaults? = UserDefaults.standard
        if defaults != nil{
            defaults?.set(stringValue, forKey: key)
            defaults?.synchronize()
        }
    }
    
    //清除手势密码
    class func clearGesturePassword () {
        self.setStringValueToUserDefault(stringValue: "", key: Gesture_passwords)
    }
    
}
