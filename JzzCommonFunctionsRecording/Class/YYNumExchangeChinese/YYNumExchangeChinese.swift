//
//  YYNumExchangeChinese.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2021/2/25.
//  Copyright © 2021 蒋状状的mac. All rights reserved.
//

import UIKit

class YYNumExchangeChinese: NSObject {

    // 数字转中文
    func eachSection(num: Int) -> String {
        var intNum = num
        let chineseNumberArr = ["零", "一", "二", "三", "四", "五", "六", "七", "八", "九"]
        let chinesePositionArr = ["", "十", "百", "千"]
        
        // 输出的中文
        var chineseNum = ""
        // 千位以下只有一个中文"零"
        var isZero = true
        for index in 0..<5 {
            // 获取末尾值(取出个位)
            let end = intNum % 10
            // 判断该数字是否为0, 若不是0, 就直接拼接权位, 若是0, 则判断是否已经出现过中文"零"
            if end == 0 {
                if !isZero  { // 上一位数不为0, 执行补0
                    isZero = true
                    chineseNum = chineseNumberArr[0] + chineseNum
                }
            }else {
                isZero = false
                chineseNum = chineseNumberArr[end] + chinesePositionArr[index] + chineseNum  // 数字 + 权位
            }
            intNum = intNum / 10; // 去除原来的个位
        }
        if chineseNum.count >= 3 && chineseNum.prefix(3) == "零一十"{
            chineseNum = String(chineseNum.suffix(chineseNum.count - 2))
        }else{
            chineseNum = String(chineseNum.suffix(chineseNum.count - 1))
        }
        return chineseNum
    }
    
}


