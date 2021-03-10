//
//  ShowGesturePasswordViewController.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2021/1/28.
//  Copyright © 2021 蒋状状的mac. All rights reserved.
//

/**
 *添加GesturePassword文件夹
 *添加SettingManager文件
 *添加一些categery里的string 和 UIView 扩展
 */

import UIKit

class ShowGesturePasswordViewController: BaseViewController {

    var gestureViewOriginX : CGFloat = kScreenH
     
 //手势密码View
 var gesturePsdView : GessturePasswordView? = {
     let gesturePsdView : GessturePasswordView = GessturePasswordView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH))
    gesturePsdView.window?.windowLevel = UIWindow.Level(rawValue: gesturePasswordViewLevel)
     
     return gesturePsdView
 }()
 
    
 lazy var setButton : UIButton = {
     let setButton = UIButton(frame: CGRect(x: (kScreenW - SP6(x: 150))/2, y: unlockButton.bottom() + SP6(x: 50), width: SP6(x: 150), height: SP6(x: 50)))
     setButton.setTitle("重新设置密码", for: .normal)
     setButton.setTitleColor(UIColor.colorWithHexString(hex: darkBlue), for: .normal)
     setButton.addTarget(self, action: #selector(resetPassword), for: .touchUpInside)
     return setButton
 }()
 
    
 lazy var unlockButton : UIButton = {
     let unlockButton = UIButton(frame: CGRect(x: (kScreenW - SP6(x: 150))/2, y: SP6(x: 200), width: SP6(x: 150), height: SP6(x: 50)))
     unlockButton.setTitle("输入密码", for: .normal)
     unlockButton.setTitleColor(UIColor.colorWithHexString(hex: darkBlue), for: .normal)
     unlockButton.addTarget(self, action: #selector(settingGesturePassword), for: .touchUpInside)
     return unlockButton
 }()
 
 override func viewDidLoad() {
     super.viewDidLoad()
    view.addSubview(unlockButton)
    view.addSubview(setButton)
    settingGesturePassword()
 }

     
    @objc func settingGesturePassword() {
         
         view.addSubview(gesturePsdView!)
         UIApplication.shared.windows.filter({ $0.isKeyWindow }).last?.addSubview(gesturePsdView!)
         self.gesturePsdView?.frame = CGRect(x: 0, y: gestureViewOriginX, width: kScreenW, height: kScreenH)
         UIView.animate(withDuration: 0.3, animations: {
             self.gesturePsdView?.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH)
         }) { (finished) in
             
         }
     }
     
     @objc func resetPassword () {
         SettingManager.clearGesturePassword()
         settingGesturePassword()
     }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
