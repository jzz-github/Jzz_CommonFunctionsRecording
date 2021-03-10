//
//  ThreeViewController.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2020/11/27.
//  Copyright © 2020 蒋状状的mac. All rights reserved.
//

/**
 YYSearchBarView
 */

import UIKit

class ThreeViewController: UIViewController,UITextFieldDelegate {

    
    lazy var searView :YYSearchBarView = {
        
        let _view = YYSearchBarView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth - 20, height: 40))
        _view.searchTextField.placeholder = "      请输入要搜索的内容"
        _view.searchTextField.layer.borderWidth = 0.4
        _view.searchTextField.layer.borderColor = UIColor.gray.cgColor
        _view.searchTextField.layer.shadowColor = UIColor.gray.cgColor
        _view.searchTextField.layer.shadowOffset = CGSize.init(width: 0.5, height: 0.5)
        _view.searchTextField.layer.shadowOpacity = 0.2
        _view.searchTextField.layer.cornerRadius = 16
        _view.searchTextField.delegate = self
        
        return _view
    }()
    
    //图片验证码
    lazy var m_validationView : ValidationView = {
        let _view = ValidationView.init(frame: CGRect.init(x:50,y:50,width:100,height:30))
        return _view
    }()
    
    //摇一摇
    lazy var shakeBtn : UIButton = {
        let _btn = UIButton.init(frame: CGRect.init(x:50,y:100,width:100,height:30))
        _btn.setTitle("摇一摇", for: .normal)
        _btn.setTitleColor(UIColor.colorWithHex(hexColor: 0x8F8F8F), for: .normal)
        _btn.backgroundColor = UIColor.white
        _btn.layer.borderColor = UIColor.colorWithHex(hexColor: 0xE0E0E0).cgColor
        _btn.layer.borderWidth = 1
        _btn.addTarget(self, action: #selector(self.pushShakeView), for: .touchUpInside)
        return _btn
    }()
    
    //摇一摇
    lazy var gradientBtn : UIButton = {
        let _btn = UIButton.init(frame: CGRect.init(x:50,y:150,width:100,height:30))
        _btn.setTitle("渐变图层", for: .normal)
        _btn.setTitleColor(UIColor.colorWithHex(hexColor: 0x8F8F8F), for: .normal)
        _btn.backgroundColor = UIColor.white
        _btn.layer.borderColor = UIColor.colorWithHex(hexColor: 0xE0E0E0).cgColor
        _btn.layer.borderWidth = 1
        _btn.addTarget(self, action: #selector(self.pushGradientView), for: .touchUpInside)
        return _btn
    }()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.yellow
        
        self.navigationItem.titleView = self.searView
        
        self.view.addSubview(self.m_validationView)
        
        self.view.addSubview(self.shakeBtn)

        self.view.addSubview(self.gradientBtn)
        /**
         测试数字转中文
         */
        print(YYNumExchangeChinese().eachSection(num: 9909))
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        print("搜索\(textField.text ?? "")")
        return true
    }

    @objc func pushShakeView(){
        
        let vc = ShakeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func pushGradientView(){
        
        let vc = GradientViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    /*
     if randomCode.lowercased() != self.m_validationView.changeString.lowercased(){
         MBProgressHUD.showMessage("请正确输入图中的字母和数字", delay: 1);
         return
     }
     */
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    


}
