//
//  config.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2020/12/4.
//  Copyright © 2020 蒋状状的mac. All rights reserved.
//

import UIKit

/**
 可在此页面的定义全局访问的属性
 */

let KSCREEN_WIDTH:CGFloat = UIScreen.main.bounds.size.width
let KSCREEN_HEIGHT:CGFloat = UIScreen.main.bounds.size.height

/// 判断是否是ipad
let kIsIpad = UIDevice.current.model == "iPad" ? true : false

//状态栏高度
let statusBarHeight = UIApplication.shared.statusBarFrame.height
//导航栏高度
let navigationHeight = (statusBarHeight + 44)
//tabbar高度
let tabBarHeight = (statusBarHeight == 44 ? 83 : 49)
//顶部的安全距离
let topSafeAreaHeight = (statusBarHeight - 20)
//底部的安全距离
let bottomSafeAreaHeight = (tabBarHeight - 49)


/// 代码延迟运行
///
/// - Parameters:
///   - delayTime: 延时时间。比如：.seconds(5)、.milliseconds(500)
///   - qosClass: 要使用的全局QOS类（默认为 nil，表示主线程）
///   - closure: 延迟运行的代码
public func delay(by delayTime: TimeInterval, qosClass: DispatchQoS.QoSClass? = nil,
                  _ closure: @escaping () -> Void) {
    let dispatchQueue = qosClass != nil ? DispatchQueue.global(qos: qosClass!) : .main
    dispatchQueue.asyncAfter(deadline: DispatchTime.now() + delayTime, execute: closure)
}
