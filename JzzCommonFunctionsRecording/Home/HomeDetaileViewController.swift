//
//  HomeDetaileViewController.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2020/11/27.
//  Copyright © 2020 蒋状状的mac. All rights reserved.
//

import UIKit
import SwiftPopMenu
import MCToast
import ActiveLabel
import Hue
import SnapKit

class HomeDetaileViewController: BaseViewController,DateTimePickerViewDelegate{
    
    ///测试ActiveLabel
    @IBOutlet weak var protocolLabel: ActiveLabel!
  
    @IBOutlet weak var testTextField: UITextField!
    
    @IBOutlet weak var testView: UIView!
    
    var popMenu:SwiftPopMenu!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "首页详情"
        self.view.backgroundColor = UIColor(hex: "#FFFFFF")
        // Do any additional setup after loading the view.
        
        ///测试ActiveLabel
        self.setUI()
        
        self.testView.addOnClickListener(target: self, action: #selector(clickView))
        
    }

    @objc func clickView(){
        MCToast.mc_success("点击了view")
    }
    
    
    @IBAction func clickBtn(_ sender: UIButton) {
       
        /**
         带箭头的弹框,不需传入箭头方向,只需传入箭头位置
         */
 
        //数据源（icon可不填）
        let popData = [(icon:"me",title:"扫一扫"),
                       (icon:"me_1",title:"分享"),
                       (icon:"home",title:"个人资料"),
                       (icon:"home_1",title:"积分兑换")]
        
        //设置参数
        let parameters:[SwiftPopMenuConfigure] = [
            .PopMenuTextColor(UIColor.black),
            .popMenuItemHeight(44),
            .PopMenuTextFont(UIFont.systemFont(ofSize: 18))
        ]
        
        //init  (test随机生成点位置，注意：arrow点是基于屏幕的位置)
        popMenu = SwiftPopMenu(menuWidth: 150, arrow: CGPoint(x: sender.center.x, y: sender.center.y+20+navigationHeight), datas: popData,configures: parameters)

        //click
        popMenu.didSelectMenuBlock = { [weak self](index:Int)->Void in
            print("block select \(index)")
            
            MCToast.mc_success("点击了\(index)行")

            self?.popMenu = nil
        }
        //show
        popMenu.show()
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
    
    
    //MARK: - DateTimePickerViewDelegate
    
    func returnDataDelegate(selectData: String) {
        print(selectData)
        
    }
    
    @IBAction func selectTime(_ sender: UIButton) {
        
        timePickerView.showView()
        
    }
    
    
    lazy var timePickerView : DateTimePickerView = {
        let view = DateTimePickerView()
        view.delegate = self
        return view
    }()
    
    
    
    
    /*
    MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



/**
 自定义输入框样式  项目中加入StringFormatter.swift文件
 */

extension HomeDetaileViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        guard let text = textField.text else {
            return true
        }
        let lastText = (text as NSString).replacingCharacters(in: range, with: string) as String
        
        if testTextField == textField {
            textField.text = lastText.format("NNN NNNN NNNN", oldString: text)
            return false
        }
        return true
    }
}
