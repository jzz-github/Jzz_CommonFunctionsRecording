//
//  JZZCycleScrollView.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2021/1/27.
//  Copyright © 2021 蒋状状的mac. All rights reserved.
//

import UIKit

///点击代理
@objc protocol JZZCycleScrollViewDidSelectDelegate:NSObjectProtocol  {
    ///图片点击
    func didSelectedImage(_ index:Int,_ indexPath:IndexPath) -> ()
}
///滑动代理
@objc protocol JZZCycleScrollViewScrollDelegate:NSObjectProtocol  {
    ///开始滑动
    func didStartScrollBanner(_ index:Int,_ indexPath:IndexPath) -> ()
    ///结束滑动
    func didEndScrollScrollBanner(_ index:Int,_ indexPath:IndexPath) -> ()
}

class JZZCycleScrollView: UIView {

    ///点击代理
    var delegateDidSelect:JZZCycleScrollViewDidSelectDelegate?
    ///滑动代理
    var delegateScroll:JZZCycleScrollViewScrollDelegate?
    
    //MARK: - PROPERTY
    private let bannerStyle: JZZBannerStyle

    var imgNames = Array<Any>()

    lazy var bannerView: BannerConfiguration = {
        let layout = JZZCollectionViewFlowLayout.init(style: self.bannerStyle)
        let banner = BannerConfiguration.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.width, height: self.frame.height), flowLayout: layout, delegate: self)
        self.addSubview(banner)
        banner.backgroundColor = self.backgroundColor
        banner.banner.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellReuseId")
        
        banner.autoPlay = true
        banner.endless = true
        banner.timeInterval = 2
        
        return banner
    }()
    
    
    init(frame: CGRect = CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: 200),style: JZZBannerStyle = JZZBannerStyle.normal) {
        self.bannerStyle = style
        super.init(frame:frame)
        self.bannerView.freshBanner()
    }
    
    required init?(coder: NSCoder) {
        self.bannerStyle = .unknown
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - BannerDelegate
extension JZZCycleScrollView: BannerConfigurationDelegate {
    func bannerNumbers() -> Int {
        return self.imgNames.count
    }
    
    func bannerView(banner: BannerConfiguration, index: Int, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = banner.banner.dequeueReusableCell(withReuseIdentifier: "cellReuseId", for: indexPath)
        var imgView = cell.contentView.viewWithTag(999)
        var label = cell.contentView.viewWithTag(888)
        if imgView == nil {
            imgView = UIImageView.init(frame: cell.contentView.bounds)
            imgView?.tag = 999
            cell.contentView.addSubview(imgView!)
            imgView?.layer.cornerRadius = 4.0
            imgView?.layer.masksToBounds = true
            
            label = UILabel.init(frame: CGRect.init(x: 30, y: 0, width: 60, height: 30))
            (label as! UILabel).textColor = UIColor.white
            (label as! UILabel).font = UIFont.systemFont(ofSize: 21)
            label?.tag = 888
            cell.contentView.addSubview(label!)
        }
        (imgView as! UIImageView).image = UIImage.init(named: self.imgNames[index] as! String)
//        (label as! UILabel).text = "\(index)" 图片左上角显示文字
        return cell
    }
    
    func didSelected(banner: BannerConfiguration, index: Int, indexPath: IndexPath) {
        print("点击 \(index) click...")
        self.delegateDidSelect?.didSelectedImage(index, indexPath)
    }
    
    func didStartScroll(banner: BannerConfiguration, index: Int, indexPath: IndexPath) {
        print("开始滑动: \(index) ...")
        self.delegateScroll?.didStartScrollBanner(index, indexPath)
    }
    
    func didEndScroll(banner: BannerConfiguration, index: Int, indexPath: IndexPath) {
        print("结束滑动: \(index) ...")
        self.delegateScroll?.didEndScrollScrollBanner(index, indexPath)
    }
}


