//
//  MineViewController.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2020/11/26.
//  Copyright © 2020 蒋状状的mac. All rights reserved.
//

import UIKit
import SnapKit

class MineViewController: UIViewController {

    lazy var testView : UIView = {
        let _view = UIView.init(frame: CGRect(x: 20, y: 10, width: 100, height: 100))
        _view.backgroundColor = UIColor.red
        return _view
    }()
    
    lazy var imageView1 : UIImageView = {
        let _view = UIImageView.init(frame: CGRect(x: 20, y: 140, width: 100, height: 100))
        _view.backgroundColor = UIColor.red
        return _view
    }()
    

 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.

        
        self.view.addSubview(self.testView)
    
        self.testView.roundCorners([.bottomLeft, .topRight], radius: 50)

        self.view.addSubview(self.imageView1)

        

        //view点击事件
//        self.testView.addOnClickListener(target: self, action: #selector(self.takeScreenshotAndSave))
 

    }


    
    @objc func someAction(){
        self.testView.backgroundColor = .yellow
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
