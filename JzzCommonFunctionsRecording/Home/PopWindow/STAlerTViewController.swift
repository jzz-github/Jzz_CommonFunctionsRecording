//
//  STAlerTViewController.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2021/1/28.
//  Copyright © 2021 蒋状状的mac. All rights reserved.
//

import UIKit
import STKitSwift
class STAlerTViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var textView: UITextView!

    @IBAction func actionButtonOne(_ sender: UIButton) {
        STHUD.show(textView.text,image: UIImage(named: "image1"),completion: nil)
      }
      
    @IBAction func actionImage(_ sender: UIButton){
          STHUD.show(textView.text, image: UIImage.init(named:"icon_ok" )) { (flag) in
              
          }
    }
      
    @IBAction func actionButton(_ sender: UIButton) {
           let title = "Flutter 与 iOS 原生 WebView 对比"
           let message = "在iOS中使用的就是原生的WKWebView，所以总体和 native WKWebView 表现差不多。如果是混编项目中，因为它被包了一层，所以页面加载上存在一定的劣势，所以混编项目中仍然推荐使用 WKWebView。不过如果从多端考虑、以及项目可迁移等，那么使用也未尝不可，就是维护成本要增加一些，需要维护两套 webView。这个就需要根据自己的情况自己取舍了"
           STAlertView.show(title: title, message: message, cancelTitle: "取消", otherTitle: "确定") { (item) in
               print(item)
       
           }
       }
       
       @IBAction func actionNoTitle(_ sender: UIButton) {
           let message = "在iOS中使用的就是原生的WKWebView，所以总体和 native WKWebView 表现差不多。如果是混编项目中，因为它被包了一层，所以页面加载上存在一定的劣势，所以混编项目中仍然推荐使用 WKWebView。不过如果从多端考虑、以及项目可迁移等，那么使用也未尝不可，就是维护成本要增加一些，需要维护两套 webView。这个就需要根据自己的情况自己取舍了"
           STAlertView.show(title: nil, message: message, cancelTitle: "取消", otherTitle: "确定") { (item) in
               print(item)
               
           }
       }
       
       @IBAction func actionNoMessage(_ sender: UIButton) {
           let title = "Flutter 与 iOS 原生 WebView 对比"
           STAlertView.show(title: title, message: nil, cancelTitle: "取消", otherTitle: "确定") { (item) in
               print(item)
               
           }
       }
       
       @IBAction func actionNoCancel(_ sender: UIButton) {
           let title = "Flutter 与 iOS 原生 WebView 对比"
           let message = "在iOS中使用的就是原生的WKWebView，所以总体和 native WKWebView 表现差不多。如果是混编项目中，因为它被包了一层，所以页面加载上存在一定的劣势，所以混编项目中仍然推荐使用 WKWebView。不过如果从多端考虑、以及项目可迁移等，那么使用也未尝不可，就是维护成本要增加一些，需要维护两套 webView。这个就需要根据自己的情况自己取舍了"
           STAlertView.show(title: title, message: message, cancelTitle: nil, otherTitle: "确定") { (item) in
               print(item)
               
           }
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
