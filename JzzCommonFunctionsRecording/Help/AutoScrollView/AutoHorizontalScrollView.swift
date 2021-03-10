//
//  AutoHorizontalScrollView.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2021/1/29.
//  Copyright © 2021 蒋状状的mac. All rights reserved.
//

import UIKit
enum AutoScrollDirection: Int {
    case left = 0
    case right
}

let  NUM_LABELS = 2

class AutoHorizontalScrollView: UIView {

    fileprivate let labels: [UILabel] = [UILabel(), UILabel()]
    
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
    
    var scrollDirection: AutoScrollDirection = .left {
        didSet {
            resizeLabels()
        }
    }
    
    var text: String? {
        set {
            if let label = labels.first, newValue == label.text {
                if label.frame.width > self.frame.width {
                    self.scrollIt()
                }
                return
            }
            for label in labels {
                label.text = newValue
            }
            self.resizeLabels()
        }
        get {
            guard let label = labels.first else {
                return nil
            }
            return label.text
        }
    }
    
    var textColor: UIColor? {
        set {
            for i in 0..<NUM_LABELS {
                labels[i].textColor = newValue
            }
        }
        get {
            if let label1 = labels.first {
                return label1.textColor
            }
            return nil
        }
    }
    
    var font: UIFont? {
        set {
            for i in 0..<NUM_LABELS {
                labels[i].font = newValue
                
            }
            resizeLabels()
        }
        get {
            if let label1 = labels.first {
                return label1.font
            }
            return nil
        }
    }
    
    var scrollSpeed: Float = 30.0 {
        didSet {
            resizeLabels()
        }
    }

    
    /// 滚动label的间距
    var labelSpace: CGFloat = 20{
        didSet {
            resizeLabels()
        }
    }
    
    var isScrolling: Bool = false
    
    func scrollIt() {
        guard isScrolling == false else {
            return
        }
        isScrolling = true
        if scrollDirection == .left {
            self.scrollView.contentOffset = CGPoint.zero
        }
        else {
            self.scrollView.contentOffset = CGPoint(x: labels[0].frame.size.width + labelSpace, y: 0)
        }
        
        UIView.animate(withDuration: TimeInterval(Float(labels[0].frame.width)/scrollSpeed),
                       delay: 0,
                       options: UIView.AnimationOptions.curveLinear,
                       animations: {
            if self.scrollDirection == .left {
                self.scrollView.contentOffset = CGPoint(x: self.labels[0].frame.width + self.labelSpace, y: 0)
            }
            else {
                self.scrollView.contentOffset = CGPoint.zero
            }
        }) { (finished) in
            self.isScrolling = false
            if finished == true, self.labels[0].frame.size.width > self.frame.width {
                self.scrollIt()

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
    
    private func setupViews(){
        scrollView.frame = self.bounds
        addSubview(scrollView)
        for label in labels {
            label.textColor = UIColor.white
            label.backgroundColor = UIColor.clear
            scrollView.addSubview(label)
        }
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.isUserInteractionEnabled = false
    }
    
    private func resizeLabels()
    {
        var offset: CGFloat = 0.0

        for labelI in labels {
            labelI.sizeToFit()
            var center = labelI.center
            center.y = self.center.y - self.frame.origin.y
            labelI.center = center
            
            var frame = labelI.frame
            frame.origin.x = offset
            labelI.frame = frame
            offset += labelI.frame.size.width + labelSpace

        }
        var size = CGSize()
        size.width = labels[0].frame.size.width + self.frame.size.width + labelSpace
        size.height = self.frame.size.height
        self.scrollView.contentSize = size
        self.scrollView.setContentOffset(CGPoint.zero, animated: false)
        
        // If the label is bigger than the space allocated, then it should scroll
        if labels[0].frame.width > self.frame.width {
            for i in 1..<NUM_LABELS {
                labels[i].isHidden = false
            }
        }
        else {
            for i in 1..<NUM_LABELS {
                labels[i].isHidden = true
            }
            var center = labels[0].center;
            center.x = self.center.x - self.frame.origin.x;
            labels[0].center = center;

        }
    }
}


extension AutoHorizontalScrollView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitTestView = super.hitTest(point, with: event)

        if self.point(inside: point, with: event), event?.type == .touches {
            debugPrint("点击事件")
            return nil
        }
        return hitTestView
    }
}

