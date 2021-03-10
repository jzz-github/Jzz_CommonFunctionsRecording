//
//  GesturePsdButton.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2021/1/28.
//  Copyright © 2021 蒋状状的mac. All rights reserved.
//

import UIKit

//按钮线宽
private let buttonCircleW : CGFloat = SP6(x: 2)
//按钮stroker圆宽
private let buttonWidth : CGFloat = SP6(x: 57)
//按钮内圆宽
private let smallButtonW : CGFloat = SP6(x: 21)
//内圆originXY
private let smallButtonXY : CGFloat = SP6(x: 20)

class GesturePsdButton: UIButton {

 
    var isHadSelected: Bool = false{
        didSet {
            if isHadSelected == true {
                isHadSelected = true
            }else{
                isHadSelected = false
            }
        }
    }
    var success : Bool = false
    var maskColor : UIColor = UIColor.white
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func draw( _ rect: CGRect) {
        
        let context : CGContext = UIGraphicsGetCurrentContext()!
        context.setLineWidth(buttonCircleW)
        if isHadSelected == true {
           
            let frame : CGRect = CGRect(x: buttonCircleW, y: buttonCircleW, width: buttonWidth, height: buttonWidth)
            context.addEllipse(in: frame)
            context.setStrokeColor(UIColor.colorWithHexString(hex: darkBlue).cgColor)
            context.strokePath()
            
            context.setFillColor(maskColor.cgColor)
            context.addEllipse(in: frame)
            context.fillPath()
        }
        
        
        
        if isHadSelected == true{
            context.setStrokeColor(red: 58, green: 110, blue: 255, alpha: 1.0)
            let frame : CGRect = CGRect(x: smallButtonXY, y: smallButtonXY, width: smallButtonW, height: smallButtonW)
            context.setFillColor(UIColor.colorWithHexString(hex: darkBlue).cgColor)
            context.addEllipse(in: frame)
            context.fillPath()
        }else{
            let frame : CGRect = CGRect(x: smallButtonXY, y: smallButtonXY, width: smallButtonW, height: smallButtonW)
            context.setFillColor(UIColor.colorWithHexString(hex: "d5dbe8").cgColor)
            context.addEllipse(in: frame)
            context.fillPath()
        }
        
    }
    
    
}

