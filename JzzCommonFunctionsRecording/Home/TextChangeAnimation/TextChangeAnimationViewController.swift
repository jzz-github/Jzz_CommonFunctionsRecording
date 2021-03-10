//
//  TextChangeAnimationViewController.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2021/2/3.
//  Copyright © 2021 蒋状状的mac. All rights reserved.
//

/**
 - 时间改变过渡动画
 - pod 'NumberMorphView'
 */

import UIKit
import NumberMorphView

class TextChangeAnimationViewController: BaseViewController {
    @IBOutlet var h0: NumberMorphView!
    @IBOutlet var h1: NumberMorphView!
    
    @IBOutlet var m0: NumberMorphView!
    @IBOutlet var m1: NumberMorphView!
    
    @IBOutlet var s0: NumberMorphView!
    @IBOutlet var s1: NumberMorphView!
    
    
    
    @IBOutlet var n1: NumberMorphView!
    @IBOutlet var n2: NumberMorphView!
    @IBOutlet var n3: NumberMorphView!
    @IBOutlet var n4: NumberMorphView!
    @IBOutlet var n5: NumberMorphView!
    @IBOutlet var n6: NumberMorphView!
    
    
    var digit = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TextChangeAnimationViewController.updateTime), userInfo: nil, repeats: true);
        n1.interpolator = NumberMorphView.LinearInterpolator();
        n2.interpolator = NumberMorphView.OvershootInterpolator();
        n3.interpolator = NumberMorphView.SpringInterpolator();
        n4.interpolator = NumberMorphView.BounceInterpolator();
        n5.interpolator = NumberMorphView.AnticipateOvershootInterpolator();
        n6.interpolator = NumberMorphView.CubicHermiteInterpolator();
    }
    
    @objc func updateTime() {
        let date = Date();
        let components = Calendar(identifier: .gregorian).dateComponents([.hour, .minute, .second], from: date);
        var hour = components.hour ?? 0;
        let minute = components.minute ?? 0;
        let second = components.second ?? 0;
        
        if hour > 12 {
            hour -= 12;
        }
        
        if hour / 10 != h1.currentDigit || h1.currentDigit == 0 {
            h1.nextDigit = hour / 10;
        }
        if hour % 10 != h0.currentDigit || h0.currentDigit == 0 {
            h0.nextDigit = hour % 10;
        }
        
        if minute / 10 != m1.currentDigit || m1.currentDigit == 0 {
            m1.nextDigit = minute / 10;
        }
        if minute % 10 != m0.currentDigit || m0.currentDigit == 0 {
            m0.nextDigit = minute % 10;
        }
        
        if second / 10 != s1.currentDigit || s1.currentDigit == 0 {
            s1.nextDigit = second / 10;
        }
        if second % 10 != s0.currentDigit || s0.currentDigit == 0 {
            s0.nextDigit = second % 10;
        }
        
        n1.nextDigit = digit;
        n2.nextDigit = digit;
        n3.nextDigit = digit;
        n4.nextDigit = digit;
        n5.nextDigit = digit;
        n6.nextDigit = digit;
        digit = (digit + 1) % 10;
    }

}
