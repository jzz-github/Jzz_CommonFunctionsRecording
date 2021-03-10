//
//  ThroughView.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2021/1/28.
//  Copyright © 2021 蒋状状的mac. All rights reserved.
//

import UIKit

class ThroughView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
        
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
       
        return nil
    }
    
}
