//
//  ShowStarViewController.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2021/1/28.
//  Copyright © 2021 蒋状状的mac. All rights reserved.
//

/**
 *添加 ZQStarRateView 文件
 *使用本页代码
 */


import UIKit

class ShowStarViewController: BaseViewController {

    lazy var starView:ZQStarRateView = {
        let view = ZQStarRateView.init(frame:  CGRect.init(x: 50, y: 100, width: UIScreen.main.bounds.width - 100, height: 40), starCount: 10, score: 0.0)
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        
        ///设置一个分数
//        self.starView.changeStarRate(score:2.3)
        // Do any additional setup after loading the view.
    }
    
    func setUI(){
        self.view.addSubview(self.starView)
        self.starView.delegate = self
        self.starView.usePanAnimation = true
        self.starView.allowUserPan = true//滑动评星
        self.starView.allowUnderCompleteStar = true //false : 整星
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

extension ShowStarViewController : ZQStarReteViewDelegate{
    
    //MARK: - 协议代理
    func starRate(view starRateView: ZQStarRateView, score: Float) {
        print(score)
        //用户评分时调用
    }
}
