//
//  ShakeViewController.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2021/2/26.
//  Copyright © 2021 蒋状状的mac. All rights reserved.
//

import UIKit
import AVFoundation
class ShakeViewController: UIViewController,AVAudioPlayerDelegate {

    var player: AVAudioPlayer?
    
    @IBOutlet var upImg: UIImageView!
    
    @IBOutlet var downImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /**
        开启摇动感应
        */
        UIApplication.shared.applicationSupportsShakeToEdit = true
        // Do any additional setup after loading the view.
    }


    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print("开始摇动")
        //开始动画
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: UIView.KeyframeAnimationOptions.beginFromCurrentState, animations: { () -> Void in
            
            self.upImg.frame.origin.y -= 80
            self.downImg.frame.origin.y += 80
            
        }, completion: nil)
        /// 设置音效
        let path1 = Bundle.main.path(forResource: "rock", ofType:"mp3")
        let data1 = try? Data(contentsOf: URL(fileURLWithPath: path1!))
        self.player = try? AVAudioPlayer(data: data1!)
        self.player?.delegate = self
        self.player?.updateMeters()//更新数据
        self.player?.prepareToPlay()//准备数据
        self.player?.play()
        
        //结束动画
        UIView.animateKeyframes(withDuration: 0.5, delay: 1.0, options: UIView.KeyframeAnimationOptions.beginFromCurrentState, animations: { () -> Void in
            
            self.upImg.frame.origin.y += 80
            self.downImg.frame.origin.y -= 80
            
        }, completion: nil)
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        ///此处设置摇一摇需要实现的功能
        /// 设置音效
        let path = Bundle.main.path(forResource: "rock_end", ofType:"mp3")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!))
        self.player = try? AVAudioPlayer(data: data!)
        self.player?.delegate = self
        self.player?.updateMeters()//更新数据
        self.player?.prepareToPlay()//准备数据
        self.player?.play()
    }
    
 
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
