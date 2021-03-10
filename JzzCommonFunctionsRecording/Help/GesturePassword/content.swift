//
//  content.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2021/1/28.
//  Copyright © 2021 蒋状状的mac. All rights reserved.
//

import UIKit

//屏幕宽高
let kScreenW : CGFloat = UIScreen.main.bounds.width
let kScreenH : CGFloat = UIScreen.main.bounds.height

//判断是否为X
let isIPhoneX = UIScreen.main.bounds.height == 812 ? true : false
//iPhoneX底部安全区域
let safeAreaBottomHeight : CGFloat = isIPhoneX ? 34 : 0

//手势密码
let Gesture_passwords : String = "Gesture_passwords"

//按手机宽缩放
public func SP6(x : CGFloat) -> CGFloat {
    let kWith = kScreenW/414
    return x * kWith
}
//左右距边缘距离
let horizontalMargin : CGFloat = 18.0
//灰色
let lightGray : String = "b4bbca"

//深蓝
let darkBlue : String = "3a6eff"

let gesturePasswordViewLevel : CGFloat = 100.0 //手势密码


