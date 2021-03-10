//
//  SecondDetailsViewController.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2020/12/4.
//  Copyright © 2020 蒋状状的mac. All rights reserved.
//

import UIKit
import MCToast
import MJRefresh
class SecondDetailsViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var images1 : Array = [UIImage.init(named: "001")]
    var images2 : Array = [UIImage.init(named: "002"),UIImage.init(named: "003"),UIImage.init(named: "004")]
    var images3 : Array = [UIImage.init(named: "005")]
    ///页码
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MJRefresh 和 无数据占位"
        self.setTableViewUI()

        // Do any additional setup after loading the view.
    }

    ///tableView设置
    func setTableViewUI(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
        
        self.tableView.backgroundColor = UIColor.clear
        
        ///去除分割线
        self.tableView.separatorStyle = .none //.singleLine
        
        self.tableView.separatorColor = UIColor.purple //tableview分割线颜色
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right:0)//tableview分割线位置

        ///去除无数据时多余分割线
        self.tableView.tableFooterView = UIView.init(frame: .zero)
        
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.showsHorizontalScrollIndicator = false
        
        self.tableView.register(UINib(nibName:"SecondDetailsViewTableViewCell", bundle:nil),
                forCellReuseIdentifier:"SecondDetailsViewTableViewCell")

        /**
        - 下拉刷新相关设置
        */
        
        // 顶部刷新
        let header = MJRefreshGifHeader()
        // 底部刷新
        let footer = MJRefreshBackNormalFooter()
        
        header.setRefreshingTarget(self, refreshingAction: #selector(self.headerRefresh))
        
        header.setTitle("下拉刷新", for: .idle)
        header.setTitle("释放更新", for: .pulling)
        header.setTitle("正在刷新...", for: .refreshing)
        
        header.setImages(self.images1 as [Any], duration: 1, for: .idle)
        header.setImages(self.images2 as [Any], duration: 1, for: .pulling)
        header.setImages(self.images3 as [Any], duration: 1, for: .refreshing)
        
        self.tableView.mj_header = header
        
        // 上拉刷新
        footer.setRefreshingTarget(self, refreshingAction: #selector(self.footerRefresh))
        
        self.tableView.mj_footer = footer
//        self.tableView.mj_footer?.isHidden = true
        
        header.beginRefreshing()
    }
    
    ///下拉刷新
    @objc func headerRefresh() {
        self.page = 1
        self.getData()
    }
    
    ///上啦加载
    @objc func footerRefresh() {
        self.page += 1
        self.getData()
    }
    
    /**
     - 获取数据
     */
    func getData(){
        
        if self.tableView.mj_header != nil{
            self.tableView.mj_header?.endRefreshing()
        }
        if self.tableView.mj_footer != nil{
//            if( r["newList"].count < 10){
                self.tableView.mj_footer?.endRefreshingWithNoMoreData()
//            }else{
//                self.tableView.mj_footer?.endRefreshing()
//            }
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

extension SecondDetailsViewController:UITableViewDelegate ,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SecondDetailsViewTableViewCell", for: indexPath) as! SecondDetailsViewTableViewCell
 
        return cell
    }

}
extension SecondDetailsViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {

    //实现第三方库协议的方法
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "大标题:现在开始,计划你的第一步"
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: CGFloat(18.0)), NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        return NSAttributedString(string: text, attributes: attributes)
    }
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "小标题:这里列举了你在这个类别下的所有计划"
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineBreakMode = .byWordWrapping
        paragraph.alignment = .center
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(14.0)), NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.paragraphStyle: paragraph]
        return NSAttributedString(string: text, attributes: attributes)

    }
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> NSAttributedString! {
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: CGFloat(17.0))]
        return NSAttributedString(string: "可点击的文字", attributes: attributes)

    }
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return UIColor.white
    }

    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return true
    }

    func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView!) -> Bool {
        return true
    }

    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }

    func emptyDataSetShouldAnimateImageView(_ scrollView: UIScrollView!) -> Bool {
        return true
    }

    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage.init(named: "007")
    }

    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {

        MCToast.mc_success("点击了按钮")

    }
    
    
}
