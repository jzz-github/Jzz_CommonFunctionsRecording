//
//  AutoVerticalScrollView.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2021/1/29.
//  Copyright © 2021 蒋状状的mac. All rights reserved.
//

import UIKit

class AutoVerticalScrollView: UIView, UIScrollViewDelegate {

    fileprivate var labels: [UILabel] = []
    
    fileprivate lazy var scrollView: UIScrollView  = {
        let scroll = UIScrollView()
        scroll.bounces = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        scroll.isPagingEnabled = true
        scroll.backgroundColor = .clear
        scroll.isUserInteractionEnabled = false
        return scroll
    }()
    
    private var timer: Timer?
    var scrollSpeed: TimeInterval = 2.0
    
    var isScrolling: Bool = false
    /// 数据源
    var textDataSource: [String] = []{
        didSet {
            setupDataSource()
        }
    }
    var textColor: UIColor = .red {
        didSet {
            for label in labels {
                label.textColor = textColor
            }
        }
    }
    var textFont: UIFont = UIFont.systemFont(ofSize: 16){
        didSet {
            for label in labels {
                label.font = textFont
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        scrollView.frame = self.bounds
        scrollView.delegate = self

        addSubview(scrollView)
    }
    
    private func setupDataSource() {
        
        labels.removeAll()
        scrollView.removeAllSubViews()
        let height = scrollView.frame.height

        for i in 0..<textDataSource.count {
            let text = textDataSource[i]
            let label = UILabel()
            label.text = text
            label.font = textFont
            label.textAlignment = .center
            label.frame = scrollView.bounds
            labels.append(label)
            
            var center = label.center
            center.y = center.y + CGFloat(i) * height
            label.center = center
            
            scrollView.addSubview(label)
            
            if text == textDataSource.last { //在最后多增加一个第一个元素，便于无限循环滚动的动画效果
                let textFirst = textDataSource.first
                let labelFirst = UILabel()
                labelFirst.text = textFirst
                labelFirst.font = textFont
                labelFirst.textAlignment = .center
                
                labelFirst.frame = scrollView.bounds
                labels.append(labelFirst)
                var center = labelFirst.center
                center.y = center.y + CGFloat(textDataSource.count) * height
                labelFirst.center = center
                
                scrollView.addSubview(labelFirst)
            }
            
            
        }
        scrollView.contentSize = CGSize(width: 0.0, height: height * CGFloat(textDataSource.count))
    }
    

    
    deinit {
        timer?.invalidate()
        timer = nil
    }
    
}

extension AutoVerticalScrollView {
    func startScroll() {
        guard textDataSource.count > 0 else {
            isScrolling = false
            return
        }
        isScrolling = true
        timer?.invalidate()
        timer = nil
        timer = Timer.every(scrollSpeed, { (tm) in
            let point = self.scrollView.contentOffset
            self.scrollView.setContentOffset(CGPoint(x: 0, y: point.y + self.frame.height), animated: true)
        })
    }
    
    func stopScroll() {
        isScrolling = false
        timer?.invalidate()
        timer = nil
        self.scrollView.setContentOffset(CGPoint.zero, animated: false)
        
    }
}
 
// MARK: - UIScrollView Delegate
extension AutoVerticalScrollView {
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if self.scrollView.contentOffset.y == self.scrollView.contentSize.height {
            self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        }
    }
}


extension UIView {
    func removeAllSubViews() {
        if self.subviews.count == 0 {
            return
        }
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
}
