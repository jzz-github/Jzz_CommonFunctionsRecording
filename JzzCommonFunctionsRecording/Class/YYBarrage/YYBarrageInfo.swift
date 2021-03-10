//
//  YYNumExchangeChinese.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2021/2/25.
//  Copyright © 2021 蒋状状的mac. All rights reserved.
//

import Foundation
import UIKit

class YYBarrageInfo {
    var text: String
    var textColor: UIColor = UIColor.black
    var itemViewClass: AnyClass = YYBarrageItemView.self
   
    init(text aText: String) {
        text = aText
        textColor = UIColor.bg
    }
    
    init(text aText: String, textColor aTextColor: UIColor) {
        text = aText
        textColor = aTextColor
    }
    
    init(text aText: String, textColor aTextColor: UIColor, itemViewClass aItemViewClass: AnyClass) {
        text = aText
        textColor = aTextColor
        itemViewClass = aItemViewClass
    }


}
