//
//  UIView+Click.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2020/12/9.
//  Copyright © 2020 蒋状状的mac. All rights reserved.
//

import UIKit

extension UIView {

    //MARK:- view Frame
    /**
    - view Frame
    */
    
    func height () -> CGFloat{
        return self.frame.size.height
    }
    
    func width () -> CGFloat{
        return self.frame.size.width
    }
    
    func right() -> CGFloat {
        return self.frame.size.width + self.frame.origin.x
    }
    
    func bottom() -> CGFloat {
        return self.frame.size.height + self.frame.origin.y
    }
    
    func top() -> CGFloat {
        return self.frame.origin.y
    }
    
    
    //MARK:- view点击事件
    /**
     - view点击事件
     */
    func addOnClickListener(target: AnyObject, action: Selector) {
        let gr = UITapGestureRecognizer(target: target, action: action)
        gr.numberOfTapsRequired = 1
        isUserInteractionEnabled = true
        addGestureRecognizer(gr)
    }

    ///设置阴影
    func setShadow(width:CGFloat,borderColor:UIColor,shadowColor:UIColor,offset:CGSize,opacity:Float,radius:CGFloat) {
        //设置视图边框宽度
        self.layer.borderWidth = width
        //设置边框颜色
        self.layer.borderColor = borderColor.cgColor
        //设置边框圆角
        self.layer.cornerRadius = radius
        //设置阴影颜色
        self.layer.shadowColor = shadowColor.cgColor
        //设置透明度
        self.layer.shadowOpacity = opacity
        //设置阴影半径
        self.layer.shadowRadius = radius
        //设置阴影偏移量
        self.layer.shadowOffset = offset
    }
    
    
    //返回该view所在的父view
    func superView<T: UIView>(of: T.Type) -> T? {
        for view in sequence(first: self.superview, next: { $0?.superview }) {
            if let father = view as? T {
                return father
            }
        }
        return nil
    }


    var x: CGFloat {
        get {
            return self.frame.origin.x
        }

        set {
            var rect = self.frame
            rect.origin.x = newValue
            self.frame = rect
        }
    }

    var y: CGFloat {
        get {
            return self.frame.origin.y
        }

        set {
            var rect = self.frame
            rect.origin.y = newValue
            self.frame = rect
        }
    }
    
    ///通过view查找所在的ViewController
    func getViewControllerByView() -> UIViewController? {
          for view in sequence(first: self.superview, next: { $0?.superview }) {
              if let responder = view?.next {
                  if responder.isKind(of: UIViewController.self){
                      return responder as? UIViewController
                  }
              }
          }
          return nil
    }
    
    
    /// SwifterSwift: Set some or all corners radiuses of view.
    ///
    /// - Parameters:
    ///   - corners: array of corners to change (example: [.bottomLeft, .topRight]).
    ///   - radius: radius for selected corners.
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius))

        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
    
    
    
}
