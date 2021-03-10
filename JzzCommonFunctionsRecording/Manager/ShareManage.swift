//
//  ShareManage.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2020/12/9.
//  Copyright © 2020 蒋状状的mac. All rights reserved.
//

import UIKit

class ShareManage: NSObject {
    
    var tValue = "df"
    
    class var shareOnce : ShareManage {
        struct tOnce {
            static let instance = ShareManage()
        }
        return tOnce.instance
    }
    
}



