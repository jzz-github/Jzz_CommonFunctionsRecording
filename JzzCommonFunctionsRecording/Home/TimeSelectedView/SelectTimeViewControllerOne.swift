//
//  SelectTimeViewControllerOne.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2021/1/21.
//  Copyright © 2021 蒋状状的mac. All rights reserved.
//
/**
 *
 *使用方法 : pod 'LXDateTimePicker'
 *showView( ) 显示视图
 *DateTimePickerViewDelegate 返回time
*/


import UIKit
import MCToast
import Hue
import SnapKit

class SelectTimeViewControllerOne: BaseViewController,DateTimePickerViewDelegate{

    
    @IBOutlet weak var timeBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(hex: "#FFFFFF")
        // Do any additional setup after loading the view.
 
    }
    
    
    //MARK: - DateTimePickerViewDelegate
    
    func returnDataDelegate(selectData: String) {
        self.timeBtn.setTitle(selectData, for: UIControl.State.normal)
        print(selectData)
        
    }
    
    
    @IBAction func selectTime(_ sender: UIButton) {
        timePickerView.showView()
    }
    
    
    lazy var timePickerView : DateTimePickerView = {
        let view = DateTimePickerView()
        view.delegate = self
        return view
    }()
    
    
    /*
    MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



