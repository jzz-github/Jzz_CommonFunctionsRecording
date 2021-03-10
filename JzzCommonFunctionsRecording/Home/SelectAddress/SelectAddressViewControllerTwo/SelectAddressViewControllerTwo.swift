//
//  SelectAddressViewControllerTwo.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2021/1/28.
//  Copyright © 2021 蒋状状的mac. All rights reserved.
//

/**
 *pod 'STKitSwift'
 *添加本页28-30 行代码
 */

import UIKit
import STKitSwift
 
class SelectAddressViewControllerTwo: BaseViewController {

   override func viewDidLoad() {
       super.viewDidLoad()
       label.snp.makeConstraints { (maker) in
           maker.width.equalTo(300)
           maker.center.equalToSuperview()
       }
   }
    
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       STAreaPickerView.show(inView: view) { [weak self](provinceName, provinceCode, cityName, cityCode, areaName, areaCode) in
           self?.label.text = "provinceName = \(provinceName ?? "")\nprovinceCode = \(provinceCode ?? "")\ncityName = \(cityName ?? "")\ncityCode = \(cityCode ?? "")\nareaName = \(areaName ?? "")\nareaCode = \(areaCode ?? "")"
       }
    
    
    
   }
   
   private lazy var label: UILabel = {
       let label = UILabel()
       label.backgroundColor = .red
       label.numberOfLines = 0
       view.addSubview(label)
       return label
   }()
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
