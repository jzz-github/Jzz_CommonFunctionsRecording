//
//  ButtonStyleViewControllerTwo.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2021/1/29.
//  Copyright © 2021 蒋状状的mac. All rights reserved.
//

/**
 UIButton+Extension
 */

import UIKit

class ButtonStyleViewControllerTwo: BaseViewController {

    @IBOutlet var btn1: UIButton!
    
    @IBOutlet var btn2: UIButton!
    
    @IBOutlet var btn3: UIButton!
    
    @IBOutlet var btn4: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btn1.Jzz_setButtonStyle(buttonMode: .Top, spacing: 10)
        btn2.Jzz_setButtonStyle(buttonMode: .Left, spacing: 10)
        btn3.Jzz_setButtonStyle(buttonMode: .Right, spacing: 10)
        btn4.Jzz_setButtonStyle(buttonMode: .Bottom, spacing: 10)
        
        // Do any additional setup after loading the view.
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
