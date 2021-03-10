//
//  ValidationView.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2021/2/25.
//  Copyright © 2021 蒋状状的mac. All rights reserved.
//

import UIKit

class ValidationView: UIView {
    var changeString:String = ""  //验证码的字符串

    let kLineCount = 6//线的条数
    let kLineWidth = CGFloat(2.0)//行间距
    let kCharCount = 4//验证码个数
    let kFontSize = UIFont.systemFont(ofSize:(CGFloat(arc4random() % 5) + 18))

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //        self.layer.cornerRadius = 5.0   //设置layer圆角半径
        //        self.layer.masksToBounds = true //隐藏边界
        self.backgroundColor = self.getChangeBgColor(alpha: 0.5)

        getChangeCode()

    }



    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func getChangeCode()
    {
        //字符素材数组
        let changeArray:NSArray = ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]

        changeString = ""
        //随机从数组中选取需要个数的字符，然后拼接为一个字符串

        for _ in 0 ..< kCharCount {
            let index = Int(arc4random())%(changeArray.count - 1)
            let getStr = changeArray.object(at: index)
            changeString = changeString + (getStr as! String)
        }

    }
    //随机生成颜色
    func getChangeBgColor(alpha:CGFloat)->UIColor{
        let randomBackColor = UIColor(red: CGFloat(CGFloat(arc4random())/CGFloat(RAND_MAX)), green: CGFloat(CGFloat(arc4random())/CGFloat(RAND_MAX)), blue: CGFloat(CGFloat(arc4random())/CGFloat(RAND_MAX)), alpha: alpha)
        return randomBackColor
    }

    //触摸
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        super.touchesBegan(touches, with: event)
        getChangeCode()
        setNeedsDisplay()
    }


    //画图
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.backgroundColor = self.getChangeBgColor(alpha: 1.0)

        //获得要显示验证码字符串，根据长度，计算每个字符显示的大概位置
        let str = NSString(string: "S")

        //        let font = UIFont.systemFontOfSize(20)
        let size = str.size(withAttributes: ([NSAttributedString.Key.font : kFontSize]))
        let width:CGFloat = rect.size.width / CGFloat(NSString(string: changeString).length) - size.width
        let height = rect.size.height - size.height
        var point:CGPoint?
        var pX:CGFloat?
        var pY:CGFloat?

//        let stringCount:Int = (changeString.characters.count)

        for i in 0 ..< kCharCount {


            pX = CGFloat(arc4random()).truncatingRemainder(dividingBy: width) + rect.size.width / CGFloat(NSString(string: changeString).length)*CGFloat(i)

            pY = CGFloat(arc4random()).truncatingRemainder(dividingBy: height)


            point = CGPoint(x:pX!, y:pY!)

            let c = NSString(string: changeString).character(at: i)

            let codeText:NSString? = NSString(format: "%C",c)

            codeText!.draw(at: point!, withAttributes:  [NSAttributedString.Key.font : kFontSize])

        }


        //调用drawRect：之前，系统会向栈中压入一个CGContextRef，调用UIGraphicsGetCurrentContext()会取栈顶的CGContextRef
        let context :CGContext = UIGraphicsGetCurrentContext()!
        //设置画线宽度

        context.setLineWidth(kLineWidth)


        for _ in 0 ..< kLineCount {
            //绘制干扰的彩色直线
            context.setStrokeColor(self.getChangeBgColor(alpha: 0.5).cgColor)


            //设置线的起点
            pX = CGFloat(arc4random()).truncatingRemainder(dividingBy: rect.size.width)
            pY = CGFloat(arc4random()).truncatingRemainder(dividingBy: rect.size.height)
            context.move(to: CGPoint(x:pX!, y:pY!))


            //设置线终点
            pX = CGFloat(arc4random()).truncatingRemainder(dividingBy: rect.size.width)
            pY = CGFloat(arc4random()).truncatingRemainder(dividingBy: rect.size.height)
            context.addLine(to: CGPoint(x:pX!, y:pY!))
            //画线
            context.strokePath()
        }


    }


    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
}
