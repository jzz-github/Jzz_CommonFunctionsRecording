//
//  HomeViewController.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2020/11/26.
//  Copyright © 2020 蒋状状的mac. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController{

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            // 隐藏首页的导航栏 true 有动画
            self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 跳转页面的导航 不隐藏 false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        self.view.backgroundColor = UIColor.cyan
        
        self.view .addSubview(self.catalogue)
        
        self.catalogue.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        print(self.mainCatalogue)
        
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
   
    
    ///目录
    lazy var catalogue : UITableView = {
       let catalogue = UITableView(frame:view.bounds, style: .grouped)
       catalogue.delegate = self;
       catalogue.dataSource = self;
       catalogue.tableFooterView = UIView(frame:CGRect.zero)//除去多余的cell
       catalogue.autoresizingMask = .flexibleWidth
       catalogue.register(UINib(nibName: "CatalogueTableViewCell", bundle: nil), forCellReuseIdentifier: "CatalogueTableViewCell")
       catalogue.separatorInset = UIEdgeInsets.zero;
       catalogue.layoutMargins = UIEdgeInsets.zero;
//       // 设置索引值颜色
//       catalogue.sectionIndexColor = UIColor.gray
//       // 设置选中时的索引背景颜色
//       catalogue.sectionIndexTrackingBackgroundColor = UIColor.colorWithHex(hexColor: 0xf2f2f2)
//       // 设置索引的背景颜色
//       catalogue.sectionIndexBackgroundColor = UIColor.colorWithHex(hexColor: 0xf2f2f2)
        
       
       return catalogue
   }()
    
    
    ///主目录数据
    var mainCatalogue = [
        ["可响应富文本Label,包含MCToast提示框","滚动","时间改变的动画1"],
        ["限制文本输入样式textField"],
        ["带箭头的弹窗","STKitSwift弹窗 (原生效果)"],
        ["时间选择器","地址选择器","地址选择器 STKITSwift(原生效果)","选择入住酒店日历(可返回开始结束时间 天数)"],
        ["轮播(含点击事件和图片浏览)"],
        ["SlideMenu"],
        ["悬浮可移动按钮","按钮样式(导入OC文件,目前只能通过xib创建,鸡肋)","扩展button 设置按钮样式"],
        ["评星"],
        ["手势解锁"]
    ]
    ///标题数据
    var titleData = ["文字效果","TextField","弹窗","选择器","轮播","SlideMenu","按钮","星星","解锁"]
    var adHeaders:[String] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","#"]
    var Headers:[String] = []
}

//MARK: - Tableview 目录

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    ///Sections 个数
    func numberOfSections(in tableView: UITableView) -> Int {
        return titleData.count
    }

    ///头部高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    ///尾部高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    //设置头视图的View
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.colorWithHex(hexColor: 0xf4f4f4)
        let lab = UILabel(frame: CGRect(x: 10, y: 10, width: KSCREEN_WIDTH-20, height: 30))
        lab.text = titleData[section]
        lab.font = UIFont.init(name: "PingFang-SC-Medium", size: 17)
        view.addSubview(lab)
        return view
    }
    
    //设置尾视图的View
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        return view
    }
    
    ///cell 高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mainCatalogue[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatalogueTableViewCell", for: indexPath) as! CatalogueTableViewCell
        cell.title_lab.text = mainCatalogue[indexPath.section][indexPath.row]
        
        return cell
    }
    
    ///点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (indexPath.section == 0) {
                    
            if (indexPath.row == 0) {
                let vc = ActiveLabelViewController()
                vc.title = "可响应事件富文本Label"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if (indexPath.row == 1) {
                let vc = TextAutoScrollViewController()
                vc.title = "文字滚动"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if (indexPath.row == 2) {
                let vc = TextChangeAnimationViewController()
                vc.title = "时间改变动画1"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            
            
        }else if (indexPath.section == 1) {
            
            if (indexPath.row == 0) {
                let vc = TextFieldTextConstraintViewController()
                vc.title = "textfield 文本输入约束"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }else if (indexPath.section == 2) {
            
            if (indexPath.row == 0) {
                let vc = WithArrowPopWindowViewController()
                vc.title = "带箭头的单选菜单"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if(indexPath.row == 1){
                
                let vc = STAlerTViewController()
                vc.title = "STAler提示框"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }else if (indexPath.section == 3) {
            
            if (indexPath.row == 0) {
                let vc = SelectTimeViewControllerOne()
                vc.title = "选择时间"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if (indexPath.row == 1) {
                let vc = SelectAddressViewControllerOne()
                vc.title = "选择地址 暂未实现"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if (indexPath.row == 2) {
                let vc = SelectAddressViewControllerTwo()
                vc.title = "选择地址 两行代码"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if (indexPath.row == 3) {
                let vc = SelectDateOfCalenderViewController()
                vc.title = "选择日期(可返回开始结束时间 天数)"
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else if (indexPath.section == 4) {
            
            if (indexPath.row == 0) {
                let vc = PageControllerViewController()
                vc.title = "轮播图(含点击事件和图片浏览)"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }else if (indexPath.section == 5) {
            
            if (indexPath.row == 0) {
                let vc = SlideMenuViewControllerOne()
                vc.title = "SlideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }else if(indexPath.section == 6){
            if(indexPath.row == 0){
                let vc = MoVableFloatButtonViewController()
                vc.title = "悬浮可移动按钮"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if(indexPath.row == 1){
                let vc = ButtonStyleViewController()
                vc.title = "导入oc文件 设置按钮样式"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if(indexPath.row == 2){
                let vc = ButtonStyleViewControllerTwo() 
                vc.title = "扩展button 设置按钮样式"
                self.navigationController?.pushViewController(vc, animated: true)
            }
 
        }else if(indexPath.section == 7){
            if(indexPath.row == 0){
                let vc = ShowStarViewController()
                vc.title = "评分星星"
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        }else if(indexPath.section == 8){
            if (indexPath.row == 0) {
                let vc = ShowGesturePasswordViewController()
                vc.title = "手势解锁"
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else if(indexPath.section == 9){
            if (indexPath.row == 0) {
                
            }
        }
 
    }
    
    /**
     索引
     */
    
    
//    //实现索引数据源代理方法
//    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return adHeaders
//    }
//    //点击索引，移动TableView的组位置
//    func tableView(_ tableView: UITableView,
//                   sectionForSectionIndexTitle title: String, at index: Int) -> Int {
//        var tpIndex:Int = 0
//        //遍历索引值
//        for character in titleData{
//            //判断索引值和组名称相等，返回组坐标
//
//            if getLetter(strInput: character) == title{
//                return tpIndex
//            }
//            tpIndex += 1
//        }
//        return 0
//    }
//
//    func getLetter(strInput:String?) -> String {
//       if strInput != nil && strInput != "" {
//           var ms:NSMutableString? = NSMutableString.init(string: strInput!)
//           CFStringTransform(ms, UnsafeMutablePointer.init(bitPattern: 0), kCFStringTransformMandarinLatin, false)
//           CFStringTransform(ms, UnsafeMutablePointer.init(bitPattern: 0), kCFStringTransformStripDiacritics, false)
//           var pyArr:[String]? = ms?.components(separatedBy: " ")
//           if pyArr != nil && (pyArr?.count)! > 0 {
//               let strResult = (pyArr![0] as NSString).substring(to: 1)
//               //数字
//               let pattern = "^[0-9]*$"
//               //替换后的
//               let str = strResult.pregReplace(pattern: pattern, with: "#")
//               return str.uppercased()
//            }
//            ms = nil
//            pyArr = nil
//       }
//       return strInput!;
//    }
    
    /**
     单个
     */
    
    
//    //在这里修改删除按钮的文字
//    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
//        return "移除"
//    }
//    //点击删除按钮的响应方法
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        let alertController = UIAlertController(title: "提示",
//                                                message:"是否删除?", preferredStyle: .alert)
//        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
//        let okAction = UIAlertAction(title: "确定", style: .default, handler: {
//            action in
//            self.deleteStu(indexPath)
//        })
//        alertController.addAction(cancelAction)
//        alertController.addAction(okAction)
//        self.present(alertController, animated: true, completion: nil)
//    }
//    func deleteStu(_ indexPath:IndexPath){
//
//    }
    
    
    /**
     多个
     */
    
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "") { [weak self] (action, view, resultClosure) in
            guard self != nil else {
                return
            }
            // TODO
        }
        let shareAction = UIContextualAction(style: .normal, title: "") { [weak self] (action, view, resultClosure) in
            guard self != nil else {
                return
            }
            // TODO
        }
        deleteAction.backgroundColor = .red
        shareAction.backgroundColor = .gray
        let actions = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
        actions.performsFirstActionWithFullSwipe = false; // 禁止侧滑到最左边触发删除或者分享回调事件
        return actions
    }
    
    //  适配iOS 11.0之后 修改侧滑删除、分享按钮
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        if #available(iOS 11.0, *) {
            for subView in tableView.subviews {
                if NSStringFromClass(subView.classForCoder) == "UISwipeActionPullView" {
                    
                    if let deleteBtn: UIButton = subView.subviews.last as? UIButton  {
                        changeAction(sourceBtn: deleteBtn, title: "取消收藏", imageStr: "collection")
                    }
                    if let shareBtn: UIButton = subView.subviews.first as? UIButton  {
                        changeAction(sourceBtn: shareBtn, title: "分享", imageStr: "share")
                    }
                    
                }else if NSStringFromClass(subView.classForCoder) == "_UITableViewCellSwipeContainerView" {
                    
                    // iOS13.0之后
                    for sub in subView.subviews {
                        if NSStringFromClass(sub.classForCoder) == "UISwipeActionPullView" {
                            if let deleteBtn: UIButton = sub.subviews.last as? UIButton  {
                                changeAction(sourceBtn: deleteBtn, title: "取消收藏", imageStr: "collection")
                            }
                            if let shareBtn: UIButton = sub.subviews.first as? UIButton  {
                                changeAction(sourceBtn: shareBtn, title: "分享", imageStr: "share")
                            }
                        }
                    }
                    
                }
            }
        }
    }

    func changeAction(sourceBtn: UIButton, title: String?, imageStr: String?) {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: 0, width: sourceBtn.frame.width, height: sourceBtn.frame.height)
        btn.backgroundColor = sourceBtn.backgroundColor
        btn.setImage(UIImage(named: imageStr ?? ""), for: .normal)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.init(name: "PingFang-SC-Medium", size: 13)
        if #available(iOS 13.0, *) {
            btn.titleLabel?.font = UIFont.init(name: "PingFang-SC-Medium", size: 13)
        } else {
            btn.contentHorizontalAlignment = .left
        }
      // 修改button的图文上下显示
        btn.Jzz_setButtonStyle(buttonMode: .Top, spacing: 3)
        btn.isUserInteractionEnabled = false
        sourceBtn.backgroundColor = .clear
        sourceBtn.addSubview(btn)
    }
    
}
