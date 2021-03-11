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


    lazy var lab_describe1 : UILabel = {
        let lab = UILabel.init(frame: CGRect(x: 20, y: 10, width: 200, height: 30))
        lab.backgroundColor = UIColor.colorWithHex(hexColor: 0xF5F5F5)
        lab.textColor = UIColor.colorWithHex(hexColor: 0x808080)
        lab.text = "部分圆角"
        lab.textAlignment = .center
        lab.font = UIFont.init(name: "HelveticaNeue-Light", size: 12)
        return lab
    }()

    lazy var lab_describe2 : UILabel = {
        let lab = UILabel.init(frame: CGRect(x: 20, y: 170, width: 200, height: 30))
        lab.backgroundColor = UIColor.colorWithHex(hexColor: 0xF5F5F5)
        lab.textColor = UIColor.colorWithHex(hexColor: 0x808080)
        lab.text = "传入颜色返回纯色图片"
        lab.textAlignment = .center
        lab.font = UIFont.init(name: "HelveticaNeue-Light", size: 12)
        return lab
    }()
    
    lazy var testView : UIView = {
        let _view = UIView.init(frame: CGRect(x: 40, y: 50, width: 100, height: 100))
        _view.backgroundColor = UIColor.red
        return _view
    }()
    
    lazy var imageView1 : UIImageView = {
        let _view = UIImageView.init(frame: CGRect(x: 40, y: 210, width: 100, height: 100))
        return _view
    }()
    

 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
        self.view.addSubview(self.lab_describe1)
        
        self.view.addSubview(self.testView)
        
        self.testView.roundCorners([.bottomLeft, .topRight], radius: 50)
        
        self.view.addSubview(self.lab_describe2)

        self.view.addSubview(self.imageView1)

        self.imageView1.image = self.creatImageWithColor(color: .cyan)
        

        //view点击事件
//        self.testView.addOnClickListener(target: self, action: #selector(self.takeScreenshotAndSave))
 

    }


    
    @objc func someAction(){
        self.testView.backgroundColor = .yellow
    }

    func creatImageWithColor(color:UIColor)->UIImage{
       let rect = CGRect(x:0,y:0,width:1,height:1)
       UIGraphicsBeginImageContext(rect.size)
       let context = UIGraphicsGetCurrentContext()
       context?.setFillColor(color.cgColor)
       context!.fill(rect)
       let image = UIGraphicsGetImageFromCurrentImageContext()
       UIGraphicsEndImageContext()
       return image!
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
