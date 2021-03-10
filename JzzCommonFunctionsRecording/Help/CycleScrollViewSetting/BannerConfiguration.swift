//
//  BannerConfiguration.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2021/1/22.
//  Copyright © 2021 蒋状状的mac. All rights reserved.
//

import UIKit

class JZZCollectionView: UICollectionView, UIGestureRecognizerDelegate {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.panGestureRecognizer.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

protocol BannerConfigurationDelegate: AnyObject {
    /// 视图数量
    func bannerNumbers() -> Int
    
    /// 加载cell
    /// - Parameters:
    ///   - banner: 控件对象
    ///   - index: 当前需要加载index
    ///   - indexPath: 当前需要加载indexPath
    func bannerView(banner: BannerConfiguration, index: Int, indexPath: IndexPath) -> UICollectionViewCell
    
    /// 点击
    /// - Parameters:
    ///   - banner: 控件对象
    ///   - index: 触发点击事件的index
    ///   - indexPath: 触发点击事件的indexPath
    func didSelected(banner: BannerConfiguration, index: Int, indexPath: IndexPath)
    
    /// 开始滚动
    /// - Parameters:
    ///   - banner: 控件对象
    ///   - index: 开始时的index
    ///   - indexPath: 开始时的indexPath
    func didStartScroll(banner: BannerConfiguration, index: Int, indexPath: IndexPath)
    
    /// 结束滚动
    /// - Parameters:
    ///   - banner: 控件对象
    ///   - index: 结束后居中的index
    ///   - indexPath: 居中后结束的indexPath
    func didEndScroll(banner: BannerConfiguration, index: Int, indexPath: IndexPath)
}

protocol BannerPageControl where Self: UIView {
    /// 当前下标
    var currentPage: Int? {set get}
    /// 总数
    var numberOfPages: Int? {get set}
    /// 自定义pageControl被添加到控件上后会调此方法, 在这里可以设置pageControl的布局
    func setupLayoutWhenMoveToBannerView(_ banner: BannerConfiguration) -> Void
    /// 设置当前下标,可以在这里处理一些动画效果 (暂时未实现)
    func setCurrentPage(_ page: Int) -> Void
    /// 设置总数,可以在这里处理视图的创建 (暂时未实现)
    func setNumberOfPages(_ number: Int) -> Void
}

class BannerConfiguration: UIView {
    //MARK: - 构造方法
    init(frame: CGRect, flowLayout: JZZCollectionViewFlowLayout, delegate: BannerConfigurationDelegate) {
        self.flowLayout = flowLayout
        self.delegate = delegate
        var rect = frame
        rect.size.height = frame.height + flowLayout.addHeight(frame.height)
        super.init(frame: rect)
        self.configureBanner()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.autoPlay
        {
            self.resumePlay()
        }
    }
    
    deinit {
        NSLog("[%@ -- %@]",NSStringFromClass(self.classForCoder), #function);
        NotificationCenter.default.removeObserver(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.flowLayout = JZZCollectionViewFlowLayout.init(style: .unknown)
        super.init(coder: aDecoder)
    }
    
    //MARK: - Property
    /// 是否展示PageControl 默认:true
    var showPageControl = true
    /// 没有数据时的占位图
    let emptyImgView = UIImageView.init(frame: CGRect.zero)
    /// 自定义layout
    let flowLayout: JZZCollectionViewFlowLayout
    /// collectionView
    lazy var banner: UICollectionView = {
//        let rect = self.bounds
        let b = JZZCollectionView.init(frame: CGRect.zero, collectionViewLayout: self.flowLayout)
        b.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(b)
        self.sendSubviewToBack(b)
        b.delegate = self
        b.dataSource = self
        b.showsHorizontalScrollIndicator = false
        b.decelerationRate = UIScrollView.DecelerationRate(rawValue: 0)
        b.backgroundColor = self.backgroundColor
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|",
                                                           options: [],
                                                           metrics: nil,
                                                           views: ["view" : b]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|",
                                                           options: [],
                                                           metrics: nil,
                                                           views: ["view" : b]))
        b.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "tempCell")
        
        self.addSubview(self.emptyImgView)
        self.emptyImgView.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[empty]|", options: [], metrics: nil, views: ["empty":emptyImgView]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[empty]|", options: [], metrics: nil, views: ["empty":emptyImgView]))
        return b
    }()
    /// 外部代理委托
    weak var delegate: BannerConfigurationDelegate?
    /// 当前居中展示的cell的下标
    var currentIndexPath: IndexPath = IndexPath.init(row: 0, section: 0) {
        didSet {
            let current = self.caculateIndex(indexPath: self.currentIndexPath)
            if self.customPageControl == nil {
                self.pageControl.currentPage = current
            }else {
//                self.customPageControl?.setCurrentPage(current)
                self.customPageControl?.currentPage = current
            }
        }
    }
    /// 是否开启自动滚动 (默认是关闭的)
    var autoPlay = false
    /// 定时器
    var timer: Timer?
    /// 自动滚动时间间隔,默认3s
    var timeInterval: TimeInterval = 3.0
    /// 默认的pageControl (默认位置在中下方,需要调整位置请自行设置frame)
    lazy var pageControl: UIPageControl = {
        let count = self.delegate?.bannerNumbers()
        let width = CGFloat(5) * CGFloat((count ?? 0))
        let height: CGFloat = 10
        let pageControl = UIPageControl.init(frame: CGRect.init(x: 0, y: 0, width: width, height: height))
        pageControl.center = CGPoint.init(x: self.bounds.width * 0.5, y: self.bounds.height - height * 0.5 - 8)
        pageControl.currentPage = 0
        pageControl.numberOfPages = self.delegate?.bannerNumbers() ?? 0
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.isUserInteractionEnabled = false;
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.translatesAutoresizingMaskIntoConstraints = false;
        return pageControl
    }()
    /// 自定义的pageControl
    var customPageControl: BannerPageControl? {
        willSet
        {
            if let custom = newValue
            {
                if custom.superview == nil
                {
                    self.addSubview(custom);
                    self.bringSubviewToFront(custom);
                    self.pageControl.removeFromSuperview();
                    newValue?.setupLayoutWhenMoveToBannerView(self)
                    newValue?.numberOfPages = self.delegate?.bannerNumbers()
                    newValue?.currentPage = 0
                }
            }
        }
    }
    
    /// 控件版本号
    var version: String {
        get{
            return "1.1.8";
        }
    }
    
    /// 是否无限轮播 true:无限衔接下去; false: 到最后一张后就没有了
    var endless: Bool = true
}

// MARK: - OPEN METHOD
extension BannerConfiguration {
    /// 刷新数据
    func freshBanner() {
        self.stop()
        self.banner.reloadData()
        self.banner.layoutIfNeeded()
        if nil != self.customPageControl {
            self.customPageControl?.numberOfPages = self.delegate?.bannerNumbers() ?? 0
            self.customPageControl?.currentPage = 0
        }else {
            self.pageControl.numberOfPages = self.delegate?.bannerNumbers() ?? 0
            self.pageControl.currentPage = 0
        }
        self.scrollToIndexPathNoAnimated(self.originIndexPath())
        if self.autoPlay {
            self.play()
        }
    }
    
    fileprivate func play() {
        if self.numbers <= 1 || self.autoPlay == false {
            self.timer?.fireDate = Date.distantFuture
            self.timer?.invalidate()
            self.timer = nil
            return
        }
        if self.timer == nil {
            if #available(iOS 10.0, *) {
                self.timer = Timer.scheduledTimer(withTimeInterval: self.timeInterval, repeats: true, block: {[weak self] (timer) in
                    self?.nextCell()
                })
            } else {
                self.timer = Timer.scheduledTimer(timeInterval: self.timeInterval, target: self, selector: #selector(nextCell), userInfo: nil, repeats: true)
            }
        }
        self.timer?.fireDate = Date.init(timeIntervalSinceNow: self.timeInterval)
    }
    
    @objc fileprivate func nextCell() {
        if self.endless
        {
            // 这里不用考虑下标越界的问题,其他地方做了保护
            self.currentIndexPath = self.currentIndexPath + 1;
        }
        else
        {
            let lastIndex = self.flowLayout.style == .normal ? self.numbers - 1 : self.factNumbers - 2
            if self.currentIndexPath.row == lastIndex
            {
                let row = self.flowLayout.style == .normal ? 0 : 1
                self.currentIndexPath = IndexPath.init(row: row, section: 0)
            }
            else
            {
                self.currentIndexPath = self.currentIndexPath + 1;
            }
        }
        self.scrollViewWillBeginDecelerating(self.banner)
    }
    
    /// 继续滚动轮播图
    func resumePlay() {
        self.pause()
        self.play()
    }
    
    /// 暂停自动滚动
    func pause() {
        if let timer = self.timer {
            timer.fireDate = Date.distantFuture
        }
    }
    
    /// 停止滚动(释放timer资源,防止内存泄漏)
    func stop() {
        self.pause()
        self.releaseTimer()
    }
    
    /// 释放timer资源,防止内存泄漏
    fileprivate func releaseTimer() {
        if let timer = self.timer {
            timer.invalidate()
            self.timer = nil
        }
    }
    
    /// banner所处控制器WillAppear方法中调用
    func bannerWillAppear() {
        if(self.autoPlay) {
            self.resumePlay()
        }
        self.adjustErrorCell(isScroll: true, animation: false)
    }
    
    /// banner所处控制器WillDisAppear方法中调用
    func bannerWillDisAppear() {
        if(self.autoPlay) {
            self.pause()
        }
        self.adjustErrorCell(isScroll: true, animation: false)
    }
}

// MARK: - LOGIC HELPER
extension BannerConfiguration {
    /// 代码层下标换算成业务层下标
    ///
    /// - Parameter IndexPath: 代码层cell对应的下标
    /// - Returns: 业务层对应的下标
    fileprivate func caculateIndex(indexPath: IndexPath) -> Int {
        guard self.numbers > 0 else
        {
            return 0
        }
        
        var row = indexPath.row % self.numbers
        if !self.endless && self.flowLayout.style != .normal
        {
            row = indexPath.row % self.factNumbers - 1
        }
        return row
    }
    
    /// 第一次加载时,会从中间开始展示
    ///
    /// - Returns: 返回对应的indexPath
    fileprivate func originIndexPath() -> IndexPath {
        
        guard self.numbers > 0 else {
            return IndexPath.init(index: 0)
        }
        
        if endless
        {
            // 判断一共可以分成多少组
            let centerIndex = self.factNumbers / self.numbers
            if centerIndex <= 1 {
                // 小于或者只有一组
                if self.numbers == 1 {
                    self.currentIndexPath = IndexPath.init(row: 0, section: 0)
                }else {
                    self.currentIndexPath = IndexPath.init(row: self.numbers, section: 0)
                }
            }else {
                // 取最中间的一组开始展示
                self.currentIndexPath = IndexPath.init(row: centerIndex / 2 * self.numbers, section: 0)
            }
            
        }
        else
        {
            let row = self.flowLayout.style == .normal ? 0 : 1
            self.currentIndexPath = IndexPath.init(row: row, section: 0)
        }
        return self.currentIndexPath
    }

    /// 边缘检测, 如果将要滑到边缘,调整位置
    fileprivate func checkOutOfBounds() {
        let row = self.currentIndexPath.row
        if row == self.factNumbers - 2
            || row == 1 {
            let originIndexPath = self.originIndexPath()
            var index = self.caculateIndex(indexPath: self.currentIndexPath)
            index = row == 1 ? index + 1 : index - 2
            self.currentIndexPath = originIndexPath + index
            self.scrollToIndexPathNoAnimated(self.currentIndexPath)
        }
    }
    
    fileprivate func scrollToIndexPathAnimated(_ indexPath: IndexPath) {
        guard self.numbers > 0 else {
            return
        }
        self.banner.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    fileprivate func scrollToIndexPathNoAnimated(_ indexPath: IndexPath) {
        guard self.numbers > 0 else {
            return
        }
        self.banner.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
    }
    
    /// cell错位检测和调整
    func adjustErrorCell(isScroll: Bool, animation: Bool = true)
    {
        let indexPaths = self.banner.indexPathsForVisibleItems
        var attriArr = [UICollectionViewLayoutAttributes?]()
        for indexPath in indexPaths
        {
            let attri = self.banner.layoutAttributesForItem(at: indexPath)
            attriArr.append(attri)
        }
        let centerX: CGFloat = self.banner.contentOffset.x + self.banner.frame.width * 0.5
        var minSpace = CGFloat(MAXFLOAT)
        var newIndexPath: IndexPath = self.currentIndexPath
        for atr in attriArr
        {
            if let obj = atr
            {
                obj.zIndex = 0;
                if(abs(minSpace) > abs(obj.center.x - centerX))
                {
                    minSpace = obj.center.x - centerX;
                    newIndexPath = obj.indexPath;
                }
            }
        }
        /// 正常情况下 newIndexPath 和 currentIndexPath 不会相差超过 2, 如果超过4明显不正常,就不做处理
        if abs(newIndexPath.row - self.currentIndexPath.row) < 4 {
            self.currentIndexPath = newIndexPath
        }
        if isScroll
        {
            self.cw_scrollViewWillBeginDecelerating(self.banner, animation: animation)
        }
    }
    
    @objc fileprivate func appActive(_ notify: Notification) {
        self.adjustErrorCell(isScroll: true, animation: false)
        self.play()
    }
    
    @objc fileprivate func appInactive(_ notify: Notification) {
        self.pause()
        self.adjustErrorCell(isScroll: true, animation: false)
    }
}

// MARK: - UI
extension BannerConfiguration {
    fileprivate func configureBanner() {
        
        if self.customPageControl == nil {
            self.addSubview(self.pageControl)
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[control]-0-|",
                                                               options: [],
                                                               metrics: nil,
                                                               views: ["control" : self.pageControl]))
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[control(30)]-0-|",
                                                               options: [],
                                                               metrics: nil,
                                                               views: ["control" : self.pageControl]))
        }else {
            self.addSubview(self.customPageControl!)
            
        }
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(appActive(_:)), name: UIApplication.didBecomeActiveNotification ,
                                               object:nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(appInactive(_:)),
                                               name: UIApplication.willResignActiveNotification,
                                               object: nil)
    }
}

// MARK: - UIScrollViewDelegate
extension BannerConfiguration {
    
    /// 开始拖拽
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        if #available(iOS 14.0, *) {
            self.banner.isPagingEnabled = false
        } else {
            self.banner.isPagingEnabled = true
        }
        if self.autoPlay {
            self.pause()
        }
        self.delegate?.didStartScroll(banner: self, index: self.caculateIndex(indexPath: self.currentIndexPath), indexPath: self.currentIndexPath)
        
    }
    
    /// 将要结束拖拽
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if (!self.endless)
        {
            var maxIndex = self.numbers - 1
            var minIndex = 0
            if self.flowLayout.style != .normal
            {
                maxIndex = self.factNumbers - 2
                minIndex = 1
            }
            
            if velocity.x >= 0 && self.currentIndexPath.row == maxIndex
            {
                self.adjustErrorCell(isScroll: true)
                return
            }
            
            if velocity.x <= 0 && self.currentIndexPath.row == minIndex
            {
                self.adjustErrorCell(isScroll: true)
                return
            }
        }
        
        // 这里不用考虑越界问题,其他地方做了保护
        if velocity.x > 0 {
            //左滑,下一张
            self.currentIndexPath = self.currentIndexPath + 1
        }else if velocity.x < 0 {
            //右滑, 上一张
            self.currentIndexPath = self.currentIndexPath - 1
        }else if velocity.x == 0 {
            self.adjustErrorCell(isScroll: false)
            if #available(iOS 14.0, *) {
                self.scrollViewWillBeginDecelerating(self.banner);
            }
        }
    }
    
    /// 将要开始减速
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        self.cw_scrollViewWillBeginDecelerating(scrollView, animation: true)
    }
    
    func cw_scrollViewWillBeginDecelerating(_ scrollView: UIScrollView, animation: Bool = true) {
        guard self.currentIndexPath.row >= 0,
            self.currentIndexPath.row < self.factNumbers else {
            // 越界保护
            return
        }
        
        if !self.endless
        {
            if self.currentIndexPath.row == 0 && self.flowLayout.style != .normal
            {
                self.currentIndexPath = IndexPath.init(row: 1, section: 0)
            }
            else if self.currentIndexPath.row == self.factNumbers - 1 && self.flowLayout.style != .normal
            {
                self.currentIndexPath = IndexPath.init(row: self.factNumbers - 2, section: 0)
            }
        }
        
        // 在这里将需要显示的cell置为居中
        if animation {
            self.scrollToIndexPathAnimated(self.currentIndexPath)
        }else {
            self.scrollToIndexPathNoAnimated(self.currentIndexPath)
        }
    }
    
    /// 结束减速
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.banner.isPagingEnabled = false
    }
    
    /// 滚动动画完成
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.banner.isPagingEnabled = false
        // 边缘检测,是否滑到了最边缘
        if self.endless
        {
            self.checkOutOfBounds()
        }
       
        if self.autoPlay {
            self.resumePlay()
        }
        self.delegate?.didEndScroll(banner: self, index: self.caculateIndex(indexPath: self.currentIndexPath), indexPath: self.currentIndexPath)
    }
    
    /// 滚动中
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.autoPlay {
            self.pause()
        }
        if false == endless {
            switch self.flowLayout.style {
            case .preview_normal:()
                
            default:()
            }
        }
    }
    
}

 // MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension BannerConfiguration: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if !self.endless
            && self.flowLayout.style != .normal
            && (indexPath.row == 0 || indexPath.row == self.factNumbers - 1)
        {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "tempCell", for: indexPath)
        }
        return self.delegate?.bannerView(banner: self,
                                         index: self.caculateIndex(indexPath: indexPath),
                                         indexPath: indexPath) ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.factNumbers
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelected(banner: self,
                                   index: self.caculateIndex(indexPath: indexPath),
                                   indexPath: indexPath)
        // 处于动画中时,点击cell,可能会出现cell不居中问题.这里处理下
        // 将里中心点最近的那个cell居
        self.adjustErrorCell(isScroll: true)
    }
}

// MARK: - Category
extension BannerConfiguration {
    /// 背地里实际返回的cell个数
    fileprivate var factNumbers: Int {
        
        guard self.numbers > 0 else
        {
            return 0;
        }
            
        self.banner.isScrollEnabled = true
        self.pageControl.isHidden = !self.showPageControl
        self.customPageControl?.isHidden = !self.showPageControl
        
        if endless
        {
            guard self.numbers > 1 else {
                // 只有一张图, 不准滑动, 隐藏pageControl
                self.banner.isScrollEnabled = false
                self.pageControl.isHidden = true
                self.customPageControl?.isHidden = true
                return self.numbers
            }
            return 100
        }
        else if self.flowLayout.style != .normal
        {
            if self.numbers == 1 {
                self.banner.isScrollEnabled = false
                self.pageControl.isHidden = true
                self.customPageControl?.isHidden = true
            }
            return self.numbers + 2
        }
        
        return self.numbers
    }
    
    /// 业务层实际需要展示的cell个数
    fileprivate var numbers: Int {
        let count = self.delegate?.bannerNumbers() ?? 0
        self.emptyImgView.isHidden = count != 0
        return count
    }
}

extension IndexPath {
    /// 重载 + 号运算符
    static func + (left: IndexPath, right: Int) -> IndexPath {
        return IndexPath.init(row: left.row + right, section: left.section)
    }
    
    /// 重载 - 号运算符
    static func - (left: IndexPath, right: Int) -> IndexPath {
        return IndexPath.init(row: left.row - right, section: left.section)
    }
}
