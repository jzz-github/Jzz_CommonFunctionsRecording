//
//  Extension+CGFloat.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2021/2/25.
//  Copyright © 2021 蒋状状的mac. All rights reserved.
//

import UIKit

extension CGFloat{
    //MARK: - 获取文字的宽度
    static func getLabelWidth(str: String, font:UIFont, height: CGFloat) -> CGFloat {
            let statusLabelText: String = str
            let size = CGSize(width: CGFloat(MAXFLOAT), height: height)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil).size
            return strSize.width
    }
    //MARK: - 获取文字的高度
    static func getTextHeigh(textStr:String,font:UIFont,width:CGFloat) -> CGFloat {
        let normalText: String = textStr
        let size = CGSize(width: width, height: CGFloat(MAXFLOAT))
        let dic = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
        let stringSize = normalText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key : Any], context:nil).size
        return stringSize.height + 10
    }
    //MARK: - 计算高度
    static func getHeightForView(text:NSAttributedString, font:UIFont, width:CGFloat) -> CGFloat{
        
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.attributedText = text
        label.sizeToFit()
        
        return label.frame.height
    }
    //MARK: - 计算内容的高度
    static func getTextHeight(param:String,width:CGFloat,fontSize:CGFloat) -> CGFloat {
        let str = param as NSString
        let textSize = str.boundingRect(with: CGSize.init(width: width, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: fontSize),NSAttributedString.Key.foregroundColor:UIColor.white], context: nil)
        return textSize.height
    }
    /// 获取指定区域的随机数
    ///
    /// - Parameters:
    ///   - lower: 下线
    ///   - upper: 上线
    /// - Returns:
    public static func randomCGFloatNumber(lower: CGFloat = 0,upper: CGFloat = 1) -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UInt32.max)) * (upper - lower) + lower
    }
    //MARK: - 底部TabBar高度
    static func returnTabBarFrameht(vc:UIViewController) -> CGFloat {
      
        if vc.tabBarController != nil{
            return vc.tabBarController?.tabBar.frame.height ?? 0
        }else{
            var parent: UIViewController?
            if let window = UIApplication.shared.delegate?.window,let rootVC = window?.rootViewController {
                parent = rootVC
                while (parent?.presentedViewController != nil) {
                    parent = parent?.presentedViewController!
                }
                
                if let tabbar = parent as? UITabBarController {
                    return tabbar.tabBar.frame.height
                }else if let nav = parent as? UINavigationController {
                    return nav.tabBarController?.tabBar.frame.height ?? 0
                }
            }
            return 0
        }
    }
}


