//
//  TentacleView.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2021/1/28.
//  Copyright © 2021 蒋状状的mac. All rights reserved.
//

import UIKit

//至少输入密码个数
private let passwordCount : Int = 5

//线宽
private let lineWidth : CGFloat = 3.0

protocol ResetDelegate : class {
    
    func resetPassword (result : String) -> Bool
}


protocol VerificationDelegate : class {
    
    func verification (result : String) ->  Bool
}

protocol TouchBeginDelegate : class {
    
    func gestureTouchBegin()
    func gestureTouchEnd ()
}



class TentacleView: UIView {
    
    weak var resetDelegate : ResetDelegate?
    weak var verifDelegate : VerificationDelegate?
    weak var touchBeginDelegate : TouchBeginDelegate?
    
    
    var lineStartPoint : CGPoint?
    var lineEndPoint : CGPoint?
    var style : Int = 1
    var buttonArray : NSArray = [GesturePsdButton()]
    
    var touchesArray : NSMutableArray = {
        let touchesArray : NSMutableArray = NSMutableArray()
        
        return touchesArray
    }()
    var touchedArray : NSMutableArray = {
        let touchedArray : NSMutableArray = NSMutableArray()
        
        return touchedArray
    }()
    var success : Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint : CGPoint?
        let touch : UITouch? = (touches as NSSet).anyObject() as? UITouch
        touchesArray.removeAllObjects()
        touchedArray.removeAllObjects()
        
        touchBeginDelegate?.gestureTouchEnd()
        success = true
        
         if touch != nil {

            touchPoint = touch?.location(in: self)
        
        for i in 0..<buttonArray.count {
            let gesButton : GesturePsdButton = buttonArray[i] as! GesturePsdButton
            gesButton.success = true
            gesButton.isHadSelected = false
            if gesButton.frame.contains(touchPoint!) {
                let point : CGPoint = gesButton.center
                let dict : NSDictionary = NSDictionary(dictionary:["x":String(describing: point.x),"y":String(describing: point.y)])

                touchesArray.add(dict)
                lineStartPoint = touchPoint
            }
            gesButton.setNeedsDisplay()
        }
        setNeedsDisplay()
         }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint : CGPoint?
        let touch : UITouch? = (touches as NSSet).anyObject() as? UITouch
        
         if touch != nil {
            touchPoint = touch?.location(in: self)
        for i in 0..<buttonArray.count {
            let gesButton : GesturePsdButton = buttonArray[i] as! GesturePsdButton
            
            if gesButton.frame.contains(touchPoint!) {
                if touchedArray.contains(("num" + String(describing: i))) {
                    
                    lineEndPoint = touchPoint
                    setNeedsDisplay()
                    return
                }
                touchedArray.add("num" + String(describing: i))
                gesButton.isHadSelected = true
                gesButton.setNeedsDisplay()
                let point : CGPoint = gesButton.center
                let dict : NSDictionary = NSDictionary(dictionary:["x":String(describing: point.x),"y":String(describing: point.y),"num":String(describing: i)])
                touchesArray.add(dict)
                break
            }
        }
        lineEndPoint = touchPoint
        setNeedsDisplay()
         }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let resultSting : NSMutableString = NSMutableString()
        if touchesArray.count < passwordCount {
            touchBeginDelegate?.gestureTouchEnd()
        }

        for dict in touchesArray{
  
            let str = (dict as AnyObject).object(forKey: "num") as? String
            
            if (str?.isEmpty)! {
                break
            }else{
                resultSting.append(str!)
            }
        }
        if style == 1 {
            success = (verifDelegate?.verification(result: resultSting as String))!
        }else{
            success = (resetDelegate?.resetPassword(result: resultSting as String))!
        }
        
        
        for i in 0..<touchesArray.count {
            let dics : NSDictionary = touchesArray.object(at: i) as! NSDictionary
            let string : String = dics.object(forKey: "num") as! String
            let selection : Int = Int((string as NSString).intValue)
            let gesButton : GesturePsdButton = buttonArray[selection] as! GesturePsdButton
            gesButton.success = success
            gesButton.setNeedsDisplay()
        }
        setNeedsDisplay()
    }

    
    override func draw(_ rect: CGRect) {
        
        for i in 0..<touchesArray.count{
            let context : CGContext = UIGraphicsGetCurrentContext()!
            let dic : NSDictionary = touchesArray.object(at: i) as! NSDictionary
  
            
            let str = dic.object(forKey: "num") as? String

            if str == nil {
            touchesArray.removeObject(at: i)
            continue
            }
            
            if success == true{
                context.setStrokeColor(UIColor.colorWithHexString(hex: darkBlue).cgColor)
            }else{
                context.setStrokeColor(UIColor.colorWithHexString(hex: darkBlue).cgColor)
            }
            
            context.setLineWidth(SP6(x: lineWidth))
            
            context.move(to: getThePoint(i: i))
            if touchesArray.count - 1 > i{
                context.addLine(to: getThePoint(i: i + 1))
            }else{
                if success == true {
                    context.addLine(to:CGPoint(x: (lineEndPoint?.x)!, y: (lineEndPoint?.y)!))
                }
            }
            context.strokePath()
        }
    }
    
    
    func enterArgin (){
        touchesArray.removeAllObjects()
        touchedArray.removeAllObjects()
        for i in 0..<buttonArray.count {
            let gesButton : GesturePsdButton = buttonArray[i] as! GesturePsdButton
            gesButton.isHadSelected = false
            gesButton.success = true
            gesButton.setNeedsDisplay()
        }
        setNeedsDisplay()
        
    }
    
}

extension TentacleView {
    
    private func getThePoint (i : Int) -> CGPoint {
        let pointDic : NSDictionary = touchesArray.object(at: i) as! NSDictionary
        let pointStrX : String = pointDic.object(forKey: "x") as! String
        let pointStrY : String = pointDic.object(forKey: "y") as! String
        
        let pointX : CGFloat = CGFloat((pointStrX as NSString).floatValue)
        let pointY : CGFloat = CGFloat((pointStrY as NSString).floatValue)
        
        return CGPoint(x: pointX, y: pointY)
    }
    
}
