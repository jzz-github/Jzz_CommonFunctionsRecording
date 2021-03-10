//
//  Extension+UIColor.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2021/1/21.
//  Copyright © 2021 蒋状状的mac. All rights reserved.
//

import UIKit

extension UIColor {


    /// 获取随机颜色
    ///
    /// - Returns: 随机颜色
    class func randomColor() -> UIColor {
        let red = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
        let green = CGFloat( arc4random_uniform(255))/CGFloat(255.0)
        let blue = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
        return UIColor(red:red, green:green, blue:blue , alpha: 1)
    }


    /// 通过 0x34e4e4 16进制获取颜色
    ///
    /// - Parameter hexColor:  16进制
    /// - Returns: 颜色
    class func colorWithHex(hexColor:Int64)->UIColor{

        return colorWithHex(hexColor: hexColor,alpha: 1);
    }
    
    
    class func colorWithHexString(hex: String) ->UIColor {
        var cString = hex.trimmingCharacters(in:CharacterSet.whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString = cString.substring(from: 1)
        }
        if (cString.count != 6){
            return UIColor.red
        }
        let rString = cString.substring(to:2)
        let otherString = cString.substring(from:2)
        let gString = otherString.substring(to:2)
        let bString = otherString.substring(from:2)
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }


    /// 通过 Int64 获取颜色
    ///
    /// - Parameters:
    ///   - hexColor: 0x34e4e4 16进制
    ///   - alpha: 透明度
    /// - Returns: 颜色
    class func colorWithHex(hexColor:Int64,alpha:CGFloat)->UIColor{

        let red = ((CGFloat)((hexColor & 0xFF0000) >> 16))/255.0;
        let green = ((CGFloat)((hexColor & 0xFF00) >> 8))/255.0;
        let blue = ((CGFloat)(hexColor & 0xFF))/255.0;

        return UIColor(red: red, green: green, blue: blue, alpha: alpha)

    }

    class func colorWithRgba(_ r: CGFloat, g: CGFloat, b: CGFloat, a:CGFloat)-> UIColor {


        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)

    }
    
    static var bg = colorWithHex(hexColor: 0x28ac86)
    static var cg = colorWithHex(hexColor: 0x28ac86)
}
