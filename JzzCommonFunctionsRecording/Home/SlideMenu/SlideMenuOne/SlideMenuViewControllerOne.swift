//
//  SlideMenuViewControllerOne.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2021/1/22.
//  Copyright © 2021 蒋状状的mac. All rights reserved.
//


/**
 *导入文件  Users/jzz/Desktop/测试项/JzzCommonFunctionsRecording/JzzCommonFunctionsRecording/Help/SlideMenuOneSetting
 *添加本页代码即可
 *
 */

import UIKit


class SlideMenuViewControllerOne: UIViewController {
    
    @IBOutlet weak var titleView0: GXSegmentTitleView!
    @IBOutlet weak var titleView1: GXSegmentTitleView!
    @IBOutlet weak var titleView2: GXSegmentTitleView!
    @IBOutlet weak var titleView3: GXSegmentTitleView!
    @IBOutlet weak var titleView4: GXSegmentTitleView!
    @IBOutlet weak var pageView: GXSegmentPageView!
    
    private lazy var items: [String] = {
        return ["要闻", "推荐", "抗肺炎", "视频", "新时代",
                "娱乐", "体育", "军事", "小视频", "微天下"]
    }()
    
    private lazy var childVCs: [UIViewController] = {
        var children: [UIViewController] = []
        for (index, title) in self.items.enumerated() {
            let vc: SlideMenuChirldViewController = SlideMenuChirldViewController(title: title)
            children.append(vc)
        }
        return children
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let config0 = GXSegmentTitleView.Configuration()
        config0.positionStyle = .none
        config0.indicatorStyle = .dynamic
        config0.indicatorFixedWidth = 30.0
        config0.indicatorFixedHeight = 2.0
        config0.indicatorAdditionWidthMargin = 5.0
        config0.indicatorAdditionHeightMargin = 2.0
        config0.isShowSeparator = true
        config0.separatorInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        self.titleView0.setupSegmentTitleView(config: config0, titles: self.items)
        
        let config1 = GXSegmentTitleView.Configuration()
        config1.positionStyle = .top
        config1.indicatorStyle = .dynamic
        config1.indicatorFixedWidth = 30.0
        config1.indicatorFixedHeight = 2.0
        config1.indicatorAdditionWidthMargin = 5.0
        config1.indicatorAdditionHeightMargin = 2.0
        config1.isShowSeparator = false
        config1.indicatorDuration = 0.0
        config1.separatorInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        self.titleView1.setupSegmentTitleView(config: config1, titles: self.items)

        let config2 = GXSegmentTitleView.Configuration()
        config2.positionStyle = .center
        config2.indicatorStyle = .dynamic
        config2.indicatorColor = UIColor.lightGray
        config2.indicatorCornerRadius = 11.0
        config2.indicatorFixedWidth = 0.0
        config2.indicatorFixedHeight = 22.0
        config2.indicatorAdditionWidthMargin = 10.0
        config2.indicatorAdditionHeightMargin = 0.0
        config2.titleSelectedColor = UIColor.white
        config2.isShowSeparator = false
        self.titleView2.setupSegmentTitleView(config: config2, titles: self.items)

        let config3 = GXSegmentTitleView.Configuration()
        config3.positionStyle = .bottom
        config3.indicatorStyle = .half
        config3.indicatorFixedWidth = 0.0
//        config3.indicatorFixedHeight = 2.0
        config3.indicatorAdditionWidthMargin = config3.titleMargin
//        config3.indicatorAdditionHeightMargin = 2.0
        config3.isShowSeparator = true
        config3.separatorInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        self.titleView3.setupSegmentTitleView(config: config3, titles: self.items)
        
        let config4 = GXSegmentTitleView.Configuration()
        config4.positionStyle = .bottom
        config4.indicatorStyle = .dynamic
        config4.indicatorFixedWidth = 30.0
        config4.indicatorFixedHeight = 2.0
        config4.indicatorAdditionWidthMargin = 5.0
        config4.indicatorAdditionHeightMargin = 2.0
        config4.isShowSeparator = false
        self.titleView4.setupSegmentTitleView(config: config4, titles: self.items)
        self.titleView4.delegate = self
        
        self.pageView.setupSegmentPageView(parent: self, children: childVCs)
        self.pageView.delegate = self
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}

extension SlideMenuViewControllerOne: GXSegmentPageViewDelegate {
    func segmentPageView(_ segmentPageView: GXSegmentPageView, at index: Int) {
        ///点击和滑动都会响应
        NSLog("index = %d", index)
    }
    func segmentPageView(_ page: GXSegmentPageView, progress: CGFloat) {
        ///滑动子页面
        NSLog("select = %d, will = %d, progress = %f", page.selectedIndex, page.willSelectedIndex, progress)
        self.titleView4.setSegmentTitleView(selectIndex: page.selectedIndex, willSelectIndex: page.willSelectedIndex, progress: progress)
    }
}

extension SlideMenuViewControllerOne: GXSegmentTitleViewDelegate {
    func segmentTitleView(_ page: GXSegmentTitleView, at index: Int) {
        ///点击slidemenu
        self.pageView.scrollToItem(to: index, animated: true)
    }
}
