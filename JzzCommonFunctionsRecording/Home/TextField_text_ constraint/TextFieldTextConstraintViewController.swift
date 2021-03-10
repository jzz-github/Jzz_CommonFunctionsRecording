//
//  TextFieldTextConstraintViewController.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2021/1/21.
//  Copyright © 2021 蒋状状的mac. All rights reserved.
//


/**
 自定义输入框样式  项目中加入StringFormatter.swift文件
 添加本页面代码
*/


import UIKit

class TextFieldTextConstraintViewController: BaseViewController {

    @IBOutlet weak var testTextField1: UITextField!
    @IBOutlet weak var testTextField2: UITextField!
    @IBOutlet weak var testTextField3: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(hex: "#FFFFFF")
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

}


extension TextFieldTextConstraintViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        guard let text = textField.text else {
            return true
        }
        let lastText = (text as NSString).replacingCharacters(in: range, with: string) as String
        
        if testTextField1 == textField {
            textField.text = lastText.format("(NNNNNN) NNNN NNNN NNNx", oldString: text)
            return false
        }
        
        if testTextField2 == textField {
            textField.text = lastText.format("NNN NNNN NNNN", oldString: text)
            return false
        }
        
        if testTextField3 == textField {
            textField.text = lastText.format("ccc ccccc", oldString: text)
            return false
        }
        return true
    }
}
