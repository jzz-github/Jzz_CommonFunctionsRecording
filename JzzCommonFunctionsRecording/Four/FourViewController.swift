//
//  FourViewController.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2020/11/27.
//  Copyright © 2020 蒋状状的mac. All rights reserved.
//

import UIKit

class FourViewController: UIViewController {

    lazy var btn_submit : UIButton = {
        let btn = UIButton()
        btn.isEnabled = true
        btn.setTitle("播放弹幕", for: .normal)
        btn.setTitle("暂停弹幕", for: .selected)
        btn.setTitleColor(UIColor.colorWithHex(hexColor: 0x8F8F8F), for: .normal)
        btn.backgroundColor = UIColor.white
        btn.layer.borderColor = UIColor.colorWithHex(hexColor: 0xE0E0E0).cgColor
        btn.layer.borderWidth = 1
        btn.addTarget(self, action: #selector(self.pushBarrage(_:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var yyBarrageView:YYBarrageView = {
           let _view = YYBarrageView.init(frame: CGRect.init(x: 0, y: 0, width: KSCREEN_WIDTH, height: KSCREEN_HEIGHT - 300))
           _view.backgroundColor = UIColor.clear
           return _view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            // 隐藏首页的导航栏 true 有动画
            self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 跳转页面的导航 不隐藏 false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.yyBarrageView.pause()//暂停
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.green
        // Do any additional setup after loading the view.
        //MARAK: 添加弹幕图层
        self.view.addSubview(self.yyBarrageView)
        
        self.view.addSubview(self.btn_submit)
      
        self.btn_submit.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(50)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
    }

    @objc func pushBarrage(_ btn:UIButton){
        btn.isSelected = !btn.isSelected
        if btn.isSelected{
            for i in 0...100{
                
                let info = YYBarrageInfo.init(text:"这是第\(i)条弹幕")
                self.yyBarrageView.pendingList.append(info)
               
            }
            self.yyBarrageView.resume()//继续
        }else{
            
            self.yyBarrageView.pause()//暂停
            
            
        }
        
        
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
