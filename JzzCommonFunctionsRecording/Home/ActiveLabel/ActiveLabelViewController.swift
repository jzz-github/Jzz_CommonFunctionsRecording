//
//  ActiveLabelViewController.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2021/1/21.
//  Copyright © 2021 蒋状状的mac. All rights reserved.
//


/**
 *ActiveLabel使用
 *只需 pod 'ActiveLabel' 添加本页面代码即可
 */

import UIKit
import ActiveLabel
import MCToast
class ActiveLabelViewController: BaseViewController {

    ///测试ActiveLabel
    @IBOutlet weak var protocolLabel: ActiveLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(hex: "#FFFFFF")
        
        ///测试ActiveLabel
        self.setUI()
        
        
        // Do any additional setup after loading the view.
    }


    @objc func setUI(){
        
        /**
         测试ActiveLabel,可用于改变协议文字颜色添加事件
         */
        
        let customType = ActiveType.custom(pattern: "\\某某协议\\b") //Looks for "are"
        let customType2 = ActiveType.custom(pattern: "\\sit\\b") //Looks for "it"
        let customType3 = ActiveType.custom(pattern: "\\ssupports\\b") //Looks for "supports"

        protocolLabel.enabledTypes.append(customType)
        protocolLabel.enabledTypes.append(customType2)
        protocolLabel.enabledTypes.append(customType3)

        protocolLabel.urlMaximumLength = 31

        protocolLabel.customize { label in
            label.text = "This is a post with #multiple #hashtags and 某某协议 supports @userhandle. Links are also supported like" +
            " this one: http://optonaut.co. Now it also supports custom patterns -> are\n\n" +
                "Let's trim a long link: \nhttps://twitter.com/twicket_app/status/649678392372121601"
            label.numberOfLines = 0
            label.lineSpacing = 5
            
            label.textColor = UIColor.gray
            label.hashtagColor = UIColor(red: 85.0/255, green: 172.0/255, blue: 238.0/255, alpha: 1)
            label.mentionColor = UIColor(red: 238.0/255, green: 85.0/255, blue: 96.0/255, alpha: 1)
            label.URLColor = UIColor(red: 85.0/255, green: 238.0/255, blue: 151.0/255, alpha: 1)
            label.URLSelectedColor = UIColor(red: 82.0/255, green: 190.0/255, blue: 41.0/255, alpha: 1)

            label.handleMentionTap { MCToast.mc_success($0) }
            label.handleHashtagTap { MCToast.mc_success($0) }
            label.handleURLTap { MCToast.mc_success($0.absoluteString) }

            //Custom types

            label.customColor[customType] = UIColor.purple
            label.customSelectedColor[customType] = UIColor.green
            label.customColor[customType2] = UIColor.magenta
            label.customSelectedColor[customType2] = UIColor.green
            
            label.configureLinkAttribute = { (type, attributes, isSelected) in
                var atts = attributes
                switch type {
                case customType3:
                    atts[NSAttributedString.Key.font] = isSelected ? UIFont.boldSystemFont(ofSize: 16) : UIFont.boldSystemFont(ofSize: 14)
                default: ()
                }
                
                return atts
            }

            label.handleCustomTap(for: customType) { MCToast.mc_success($0) }
            label.handleCustomTap(for: customType2) { MCToast.mc_success($0) }
            label.handleCustomTap(for: customType3) { MCToast.mc_success($0) }
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

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
