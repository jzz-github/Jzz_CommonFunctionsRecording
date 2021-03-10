//
//  MoVableFloatButtonViewController.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2021/1/28.
//  Copyright © 2021 蒋状状的mac. All rights reserved.
//

import UIKit
import STKitSwift
import MCToast
class MoVableFloatButtonViewController: UIViewController {

     override func viewDidLoad() {
         super.viewDidLoad()
         moveButton.snp.makeConstraints { (maker) in
             maker.bottom.equalTo(-100)
             maker.right.equalTo(-16)
         }
     }

     private lazy var moveButton: STMoveButton = {
         let moveButton = STMoveButton()
         moveButton.setImage(UIImage.init(named: "icon_wheel"), for: .normal)
        moveButton.addTarget(self, action: #selector(self.clickAct), for: .touchUpInside)
         view.addSubview(moveButton)
         return moveButton
     }()
    

    @objc func clickAct(){
        MCToast.mc_success("你点我弄啥 ! ! !")
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
