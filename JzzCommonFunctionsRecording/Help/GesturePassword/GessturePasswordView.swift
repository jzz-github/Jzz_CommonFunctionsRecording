//
//  GessturePasswordView.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2021/1/28.
//  Copyright © 2021 蒋状状的mac. All rights reserved.
//

import UIKit
import AudioToolbox

//设置密码的最少个数
private let gesturePsdCount : Int = 5

//按钮宽
private let buttonWidth : CGFloat = SP6(x: 61)
private let distanceW : CGFloat = SP6(x: 40)

enum MessageLabelType : Int{
    case InportGesturePassword = 0
    case GesturePasswordError
    case GesturePasswordSuccess
    case GesturePasswordCount
    case InputGesturePasswordAgain
    case GesturePasswordPutedin
    case GesturePasswordLeftCounts //手势密码剩余次数
    case GesturePasswordTouchEnd//
    case GesturePasswordMobileNuber
}

class GessturePasswordView: UIView {

    //剩余输入手势密码次数
    var inputCount : Int = 5
    
    var recordGesturePsdResult : String = ""
    
    
    var messageType : MessageLabelType = .InportGesturePassword{
        
        didSet{
            if messageType == .InportGesturePassword{
                messageLabel.text = "请绘制新的手势密码"
                messageLabel.textColor = UIColor.colorWithHexString(hex: lightGray)
            }else if messageType == .GesturePasswordError {
                messageLabel.text = "两次密码不一致,请重新设置"
                messageLabel.textColor = UIColor.colorWithHexString(hex: darkBlue)
            }else if messageType == .GesturePasswordCount{
                messageLabel.text = "手势密码至少绘制\(gesturePsdCount)个点,请重新设置"
                messageLabel.textColor = UIColor.colorWithHexString(hex: darkBlue)
            }else if messageType == .GesturePasswordTouchEnd{
                messageLabel.text = "手势密码至少绘制\(gesturePsdCount)个点"
                messageLabel.textColor = UIColor.colorWithHexString(hex: darkBlue)
            }else if messageType == .InputGesturePasswordAgain {
                messageLabel.text = "请再次确认密码"
                messageLabel.textColor = UIColor.colorWithHexString(hex: lightGray)
            }else if messageType == .GesturePasswordPutedin{
                messageLabel.text = "手势密码已保存"
                messageLabel.textColor = UIColor.colorWithHexString(hex: lightGray)
            }else if messageType == .GesturePasswordMobileNuber{
                
                messageLabel.text = "199****3239"
                messageLabel.textColor = UIColor.colorWithHexString(hex: lightGray)
            }else if messageType == .GesturePasswordLeftCounts{
                messageLabel.text = "手势密码错误,您还可以尝试\(inputCount)次"
                messageLabel.textColor = UIColor.colorWithHexString(hex: darkBlue)
            }else {
                messageLabel.text = "输入正确"
                messageLabel.textColor = UIColor.colorWithHexString(hex: lightGray)
            }
        }
        
    }
    
    
    //提示语
    lazy var messageLabel : UILabel = {
        let frame : CGRect = CGRect(x: SP6(x: horizontalMargin), y:buttonsView.frame.minY - SP6(x: 59), width: kScreenW - 2 * horizontalMargin, height: SP6(x: 20))
        let messageLabel : UILabel = UILabel(frame: frame)
            messageLabel.textAlignment = .center
         messageLabel.text = "请绘制新的手势密码"
        messageLabel.textColor = UIColor.colorWithHexString(hex: lightGray)
            messageLabel.font = UIFont.systemFont(ofSize: SP6(x: 15))
        return messageLabel
    }()
    
    
    //图像
    lazy var iconImageView : UIImageView = {
        let frame : CGRect = CGRect(x: (kScreenW - SP6(x: 74))/2, y: messageLabel.frame.minY - SP6(x: 104), width: SP6(x: 74), height: SP6(x: 74))
        let iconImageView : UIImageView = UIImageView(frame: frame)
        iconImageView.backgroundColor = UIColor.colorWithHexString(hex: "d5dbe8")
        iconImageView.layer.cornerRadius = SP6(x: 74.0/2)
        iconImageView.layer.masksToBounds = true
        iconImageView.image = UIImage.init(named: "image1")
        return iconImageView
    }()
    
    
    //底部按钮
    lazy var bottomView : ForgetGesturePasswordView = {
        let bottomView : ForgetGesturePasswordView = ForgetGesturePasswordView(frame: CGRect(x: 0, y: kScreenH - SP6(x: 30) - SP6(x: 34) - safeAreaBottomHeight, width: kScreenW, height: SP6(x: 30)))
        bottomView.isHidden = true
        bottomView.forgetPsdButton.addTarget(self, action: #selector(forgetFingerGessturePasswordClicked), for: .touchUpInside)
      
       return bottomView
    }()
    
    //触摸view
    lazy var tentacleView : TentacleView = {
        let tentacleView : TentacleView = TentacleView(frame: buttonsView.bounds)
        tentacleView.buttonArray = buttonArray
    
        return tentacleView
    }()
    
    lazy var troughView : ThroughView = {
        let troughView : ThroughView = ThroughView(frame: tentacleView.frame)
        
        return troughView
    }()
    
    lazy var buttonArray : NSMutableArray = {
        let buttonArray : NSMutableArray = NSMutableArray()
        
        return buttonArray
    }()
    
    lazy var buttonsView : UIView = {
        let frame : CGRect = CGRect(x:SP6(x: 1.5), y:SP6(x: 1.5), width: SP6(x: 260), height: SP6(x: 260))
        let buttonsView : UIView = UIView(frame: frame)
        buttonsView.center = self.center
        
        return buttonsView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        addSubview(buttonsView)
        addSubview(messageLabel)
        addSubview(iconImageView)
        addSubview(bottomView)
        createButtonViewUI()
    }
 
 
    
    override func willMove(toWindow newWindow: UIWindow?) {
        if newWindow != nil {
            newWindow?.endEditing(true)
            tentacleView.verifDelegate = nil
            tentacleView.resetDelegate = nil
            tentacleView.touchBeginDelegate = self
            //判断是否存在手势密码
            if judgeIsHadGesturePassword(){
                bottomView.isHidden = false
                certifyGesturePassWord()
              bottomView.isShowIDunlock = false
              
            }else{
                bottomView.isHidden = true
                recordGesturePsdResult = ""
                clearGesturePassword()
                resetGesturePassword()
                
            }
  
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension GessturePasswordView {
    
    private func createButtonViewUI () {
        for i in 0..<9{
            
            let row : CGFloat = CGFloat(i/3)
            let col : CGFloat = CGFloat(i%3)
            
            let gesBtn : GesturePsdButton = GesturePsdButton(frame: CGRect(x: col * (distanceW + buttonWidth), y: row * (distanceW + buttonWidth), width: buttonWidth, height: buttonWidth))
            gesBtn.maskColor = UIColor.colorWithHexString(hex: "ffffff")
            troughView.addSubview(gesBtn)
            buttonArray.add(gesBtn)
            
        }
        buttonsView.addSubview(tentacleView)
        buttonsView.addSubview(troughView)
        
    }
    
}


extension GessturePasswordView : TouchBeginDelegate,VerificationDelegate,ResetDelegate{
    //重置手势密码协议
    func resetPassword(result: String) -> Bool {
        
        
        if result.count < gesturePsdCount {
            resetGesturePassword()
            vibrate()
            tentacleView.enterArgin()
            messageType = .GesturePasswordCount
            recordGesturePsdResult = ""
            return false
        }
        
        if recordGesturePsdResult.count == 0 {
            recordGesturePsdResult = result
            tentacleView.enterArgin()
            messageType = .InputGesturePasswordAgain
            return true
        }else{
            if result == recordGesturePsdResult {
                SettingManager.setStringValueToUserDefault(stringValue: result, key: Gesture_passwords)
                messageType = .GesturePasswordPutedin
                print("手势密码设置成功")
                
                dismissGestureView()
                return true
            }else{
                resetGesturePassword()
                vibrate()
                recordGesturePsdResult = ""
                messageType = .GesturePasswordError
                tentacleView.enterArgin()
                if judgeIsHadGesturePassword(){
                    clearGesturePassword()
                }
                return false
            }
            
        }
        
    }
    
    //验证手势密码
    func verification(result: String) -> Bool {
        let passWord : String = SettingManager.getStringValueforKey(key: Gesture_passwords)
        
        if result == passWord{
            messageType = .GesturePasswordSuccess
            dismissGestureView()
            return true
        }else{
            certifyGesturePassWord()
            vibrate()
            inputCount = inputCount - 1
           messageType = .GesturePasswordLeftCounts
            if inputCount == 0{
                forgetFingerGessturePasswordClicked()
            }
        return false
        }
    }
    
    
    func gestureTouchBegin() {
        messageLabel.text = ""
    }
    
    func gestureTouchEnd() {
       messageType = .GesturePasswordTouchEnd
      
    }
    
}


//dismiss手势View
extension GessturePasswordView {
    
    private func dismissGestureView () {
    
            DispatchQueue.main.async {
                
                UIView.animate(withDuration: 0.3, animations: {
                    
                    self.frame = CGRect(x: 0, y:kScreenH, width: kScreenW, height: kScreenH)
                    
                }) { (finished) in
                    self.inputCount = gesturePsdCount
                    self.removeFromSuperview()
                    self.tentacleView.enterArgin()
                }
            }
 
        }
    
}

//验证手势密码
extension GessturePasswordView{
    
    func certifyGesturePassWord () {
        
        tentacleView.style = 1
         tentacleView.enterArgin()
        messageType = .GesturePasswordMobileNuber
        tentacleView.verifDelegate = self
    }
    
}

//指纹解锁，忘记手势密码
extension GessturePasswordView {
    
    //忘记手势密码
    @objc func forgetFingerGessturePasswordClicked () {
        
        
        SettingManager.clearGesturePassword()
         /*****移除个人信息*******/
     
        
        /*****弹出登录页面*******/
 
        
        dismissGestureView()
        
    }
    
  
    
    //添加震动效果
    func vibrate (){
        let soundID = SystemSoundID(kSystemSoundID_Vibrate)
        AudioServicesPlaySystemSound(soundID)
    }
    
    //清除手势密码
    func clearGesturePassword () {
         tentacleView.enterArgin()
      SettingManager.clearGesturePassword()
    }
    
    //重置手势密码
    func resetGesturePassword (){
        inputCount = 5
        messageType = .InportGesturePassword
        tentacleView.resetDelegate = self
        tentacleView.style = 2
        bottomView.isHidden = true
        
    }
    
    //判断是否有手势密码
    func judgeIsHadGesturePassword () -> Bool {
        let password : String? = SettingManager.getStringValueforKey(key: Gesture_passwords)
        if password == nil || password?.count == 0 {
            return false
        }else{
            return true
        }
    }
    
    
    //改变手势密码
    func changeGesturePassword () {
        clearGesturePassword()
        resetGesturePassword()
    }
}


