//
//  GradientViewController.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2021/3/2.
//  Copyright © 2021 蒋状状的mac. All rights reserved.
//
  
import UIKit

class GradientViewController: UIViewController {

    var label = UILabel(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
    
    var story = "  \n 直到现在我才明白\n 我不是北京，你也不是西雅图\n 我等不到你嫁给我的那天\n 我们之间也没有未来\n 但，我爱你\n 就算知道没有结果，我也爱你"

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)

        self.title = "颜色渐变"
        
        self.view.addSubview(self.label)
        self.label.numberOfLines = 0
        self.label.text = ""
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.colors = [UIColor(red: 0.0, green: 1.0, blue: 0.752, alpha: 1.0).cgColor,
                           UIColor(red: 0.949, green: 0.03, blue: 0.913, alpha: 1.0).cgColor]
        view.layer.addSublayer(gradient)
        gradient.mask = label.layer
        
        punchText(text: story)

        let imageView = UIImageView(image: UIImage(named: "007"))
        imageView.center.x = label.bounds.width/2
        label.addSubview(imageView)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension GradientViewController {
    func punchText(text: String) {
        if text.count > 0 {
            label.attributedText = self.getAttributeStringWithString("\(label.text!)\(text.prefix(1))", lineSpace: 10) //text.prefix(1)截取第一位
            delay(by: 0.1) {self.punchText(text: String(text.suffix(text.count - 1)))}//text.suffix(text.count - 1)截取最后多少位
        } else {
            delay(by: 0.1) {self.addButtonRing()}
            delay(by: 1.2) {self.addButtonRing()}
            delay(by: 2.4) {self.addButtonRing()}
        }
    }
}

extension GradientViewController {
    // 按钮动画
    func addButtonRing() {
        let side: CGFloat = 60.0
        let button = CAShapeLayer()
        
        button.position = CGPoint(x: label.bounds.width * 0.5 - side/2, y: label.bounds.height * 0.7)
        button.strokeColor = UIColor.black.cgColor
        button.fillColor = UIColor.clear.cgColor
        button.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: side, height: side)).cgPath

        button.lineWidth = 1.0
        button.opacity = 0.5
        label.layer.addSublayer(button)
        
        let scale = CABasicAnimation(keyPath: "transform.scale")
        scale.fromValue = 1.0
        scale.toValue = 0.67
        scale.duration = 2.0
        scale.repeatCount = Float.infinity
        scale.autoreverses = true
        button.add(scale, forKey: nil)
        
    }
}

extension GradientViewController {
    // 为UILabel添加行间距
    fileprivate func getAttributeStringWithString(_ string: String,lineSpace:CGFloat
        ) -> NSAttributedString{
        let attributedString = NSMutableAttributedString(string: string)
        let paragraphStye = NSMutableParagraphStyle()
        
        //调整行间距
        paragraphStye.lineSpacing = lineSpace
        paragraphStye.alignment = .center
        let rang = NSMakeRange(0, CFStringGetLength(string as CFString))
        attributedString .addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStye, range: rang)
        return attributedString
    }
}

