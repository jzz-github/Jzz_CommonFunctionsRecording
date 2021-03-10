//
//  SelectAddressViewControllerOne.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2021/1/22.
//  Copyright © 2021 蒋状状的mac. All rights reserved.
//

import UIKit

class SelectAddressViewControllerOne: BaseViewController {

    ///选择地址pickerview
    @IBOutlet weak var selectAddressView: UIPickerView!
    
//    //选中地址数组
//    var selectAddressArray = Array<Any>()
//
//    //选择的省下标默认0
//    var provincialIndex = 0
//    //选择的省
//    var provincialStr = ""
//    //省数组
//    var provincialArr = Array<String>()
//
//    //选择的市下标默认0
//    var cityIndex = 0
//    //选择市
//    var cityStr = ""
//    //市数组
//    var cityArr = Array<Any>()
//
//
//    //选择的区下标默认0
//    var areaIndex = 0
//    //选择区
//    var area = ""
//    //区数组
//    var areaArr = Array<Any>()
//
//    var pickerDic = Dictionary<String, Any>()
//
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.pickerViewConfiguration()
//        self.loadData()
//        self.getAddressList()
    }
//
//    ///配置
//    func pickerViewConfiguration(){
//        self.selectAddressView.dataSource = self
//        self.selectAddressView.delegate = self
//    }
//
//    func loadData(){
//        var path = ""
//        path = Bundle.main.path(forResource: "ChinaAddress",ofType: "plist") ?? ""
//        self.pickerDic = NSMutableDictionary(contentsOfFile: path) as! [String : Any]
//        print(pickerDic)
//        ///获取字典第一层所有的key      省份
//        self.provincialArr = Array(self.pickerDic.keys)
//        ///获取字典第一层 第一个 key 下的所有数据        市区
//        self.selectAddressArray = Array(arrayLiteral: self.pickerDic[self.provincialArr[0]] as Any)
//        ///如果第一层第一个key是有数据的 获取第一层第一个key 下的第二层所有的key      市
//        if (self.selectAddressArray.count > 0) {
//
//            self.cityArr = Array(arrayLiteral: self.selectAddressArray[0])
//        }
//
//        if(self.cityArr.count > 0) {
//            self.areaArr = Array(arrayLiteral: self.selectAddressArray[0])
//        }
//
//    }
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
//
//extension SelectAddressViewControllerOne: UIPickerViewDataSource, UIPickerViewDelegate{
//
//    //设置选择框的总行数,继承于UIPickViewDataSource协议
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 3;
//    }
//
//    //设置选择框的总行数,继承于UIPickViewDataSource协议
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        if(component == 0){
//            //选择第一级数据
//            return self.provincialArr.count
//        }else if(component == 1){
//            //选择第二级数据
//            return self.cityArr.count
//        }else{//选择第三级数据
//            return self.areaArr.count
//        }
//    }
//
//    //设置选项框各选项的内容,继承于UIPickViewDelegate协议
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
//        if(component == 0){
//            //选择第一级数据
//            return (self.provincialArr[row] as! String)
//        }else if(component == 1){
//            //选择第二级数据
//            return (self.cityArr[row] as! String)
//        }else{
//            //选择第三级数据
//            return (self.areaArr[row] as! String)
//        }
//    }
//
//    //选择控件的事件选择
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//
//        if(component == 0){
//
//        }else if(component == 1){
//
//        }
//
//    }
//
//    //设置每行选项的高度
//    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
//        return 45.0
//    }
//
//    // 获取值
//    func onclick() {
//
//        //获得3列选取值的下标
//        let row1 = self.selectAddressView.selectedRow(inComponent: 0)
//        let row2 = self.selectAddressView.selectedRow(inComponent: 1)
//        let row3 = self.selectAddressView.selectedRow(inComponent: 2)
//        // 根据下标获取值
//        let selected1 = self.provincialArr[row1] as! String
//        let selected2 = self.cityArr[row2] as! String
//        let selected3 = self.areaArr[row3] as! String
//        //拼接值
//        let title = String(format: "%@,%@,%@",selected1,selected2,selected3)
//        print(title)
//    }
//
//    func getAddressList(){
//
//    }
//
//

}
