//
//  YYNumExchangeChinese.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2021/2/25.
//  Copyright © 2021 蒋状状的mac. All rights reserved.
//

import Foundation
import UIKit

class YYBarrageItemView: UIView {

    typealias T = YYBarrageInfo
    
    let leftMargin: CGFloat = 10
    let topMargin: CGFloat = 5
    
    lazy var defaultHeight: CGFloat = {
        let text: NSString = "#"
        let constraintRect = CGSize(width: self.bounds.size.width, height: CGFloat(MAXFLOAT))
        
        let boundingBox = text.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: self.label.font], context: nil)
        
        return boundingBox.height
    }()
    
    lazy var label: UILabel = {
        var label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.black
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.layer.masksToBounds = true

        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        self.addSubview(label)
    }
    
    func updateDanmuInfo(info: YYBarrageInfo) {
        label.text = info.text
        label.textColor = info.textColor
        
        setNeedsLayout()
    }
    
    func updateAttributedText(text: NSAttributedString) {
        label.attributedText = text
        setNeedsLayout()
    }
    
    override func sizeToFit() {
        super.sizeToFit()
        
        label.sizeToFit()
        
        label.frame = CGRect(x: leftMargin, y: topMargin, width: label.frame.size.width, height: label.frame.size.height)
        
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: label.frame.size.width + 2 * leftMargin, height: label.frame.size.height + 2 * topMargin)
         self.layer.cornerRadius =  self.frame.height / 2
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.sizeToFit()
    }
}
