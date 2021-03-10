//
//  PageControllerViewController.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2021/1/21.
//  Copyright © 2021 蒋状状的mac. All rights reserved.
//

/**
 轮播图样式

 [
 JZZBannerStyle.normal,
 JZZBannerStyle.preview_normal,
 JZZBannerStyle.preview_zoom,
 JZZBannerStyle.preview_big
 ]
 
 项目中添加 本项目的CycleScrollViewSetting 文件夹中的三个文件
 使用本页的代码即可
 */

import UIKit
import JXPhotoBrowser

class PageControllerViewController: BaseViewController {

    let bannerWidth = KSCREEN_WIDTH
    let bannerHeight = 200
    
    ///轮播图懒加载
    lazy var banner:JZZCycleScrollView = {
        let _bannerView = JZZCycleScrollView.init(frame: CGRect(x: 0, y: 0, width: Int(bannerWidth), height: bannerHeight))
           _bannerView.delegateDidSelect = self
           return _bannerView
       }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        ///添加视图
        self.view.addSubview(self.banner)
        self.banner.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(bannerWidth)
            make.height.equalTo(bannerHeight)
        }
        self.addDataAndRefresh()
        // Do any additional setup after loading the view.
    }
    
    
    func addDataAndRefresh(){
        ///添加数据
        self.banner.imgNames = ["01.jpg","02.jpg","03.jpg","04.jpg","05.jpg"]
        ///刷新视图
        self.banner.bannerView.freshBanner()
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

//MARK: - 点击代理
extension PageControllerViewController :JZZCycleScrollViewDidSelectDelegate{
    
    func didSelectedImage(_ index: Int, _ indexPath: IndexPath) {
        print("++++++点击+++++ \(index) click...")
        
        /**
         *图片浏览器
         *pod 'JXPhotoBrowser', '~> 3.0'
         */
        
        let browser = JXPhotoBrowser()
        browser.numberOfItems = {
            self.banner.imgNames.count
        }
        browser.pageIndex = index
        browser.reloadCellAtIndex = { context in
            let browserCell = context.cell as? JXPhotoBrowserImageCell
            let indexPath = IndexPath(item: context.index, section: indexPath.section)
            browserCell?.imageView.image = UIImage(named: self.banner.imgNames[indexPath.item] as! String)
        }
        
        ///第几张图片的提示
//        browser.pageIndicator = JXPhotoBrowserDefaultPageIndicator() //默认 无
        browser.pageIndicator = JXPhotoBrowserNumberPageIndicator() //数字
        ///转场动画
        browser.transitionAnimator = JXPhotoBrowserFadeAnimator() //默认 渐变
   
        
        browser.show()
    }
}
