//
//  DateManager.swift
//  JzzCommonFunctionsRecording
//
//  Created by 蒋状状的mac on 2021/1/29.
//  Copyright © 2021 蒋状状的mac. All rights reserved.
//

import UIKit

class DateManager {
    
    
    class var dateManager : DateManager {
        struct data {
            static let instance = DateManager()
        }
        return data.instance
    }
    
// MARK: - 日期格式转字符串
    
  func switchToNSDateFrom(_ dateString: String, dateFormat: String) -> Date? {

       let formatter = DateFormatter()

       formatter.dateFormat = dateFormat

       return formatter.date(from: dateString)

   }
    
// MARK: - 日期转字符串格式

   /**
     - 日期转字符串格式
    */

   func switchToStringFrom(_ date: Date, dateFormat: String) -> String? {

       let formatter = DateFormatter()

       formatter.dateFormat = dateFormat

       return formatter.string(from: date)

   }

// MARK: - 计算两日期间相差的天数

   /**
     - 计算两日期间相差的天数
    */

   func distancesFrom(_ startingDate: Date, to resultDate: Date) -> Int {

       let gregorian = Calendar(identifier: Calendar.Identifier.gregorian)

       //如果计算相差的小时数，可改为.Calendar.Unit.Hour; day改为hour

       let comps = (gregorian as NSCalendar).components(NSCalendar.Unit.day, from: startingDate, to: resultDate, options:.wrapComponents)
    
       return comps.day!
   }
    
// MARK: - 获取本地时区与世界零时区的时差

   /**
     - 获取本地时区与世界零时区的时差
    */

   func distanceIntervalForLocalTimeZon() -> Int {

        return TimeZone.autoupdatingCurrent.secondsFromGMT(for: Date())

   }
    

// MARK: - 指定日期,所在的“day”单元，在“month”中有多少个（即指定日期所在月有多少天）

    /**
    指定日期,所在的“day”单元，在“month”中有多少个（即指定日期所在月有多少天）
    */

    func numberOfDaysInMonthDepandOn(_ date: Date) -> Int {

        return (Calendar.current as NSCalendar).range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: date).length

    }
    

// MARK: - 指定日期为当周的周几(1为周日)
     
    /**
    指定日期为当周的周几(1为周日)
    */
 
    func dayIndexInWeeklyDepandOn(_ date: Date) -> Int {
 
        // 把目标日期转为yyy-MM-dd字符串
 
        let dateFormatter = DateFormatter()
 
        dateFormatter.dateFormat = "yyyy-MM-dd"
 
        let dateString = dateFormatter.string(from: date)
 
        // 取出对应的 年、月、日
 
        let dateArr: [String] = dateString.components(separatedBy: "-")
 
        // 设置NSDateComponts
 
        var dateComponts = DateComponents()
 
        dateComponts.setValue(Int(truncating: NumberFormatter().number(from: dateArr[0])!), for: .year)
        dateComponts.setValue(Int(truncating: NumberFormatter().number(from: dateArr[1])!), for: .month)

        dateComponts.setValue(Int(truncating: NumberFormatter().number(from: dateArr[2])!), for: .day)

        let targetDate = Calendar.current.date(from: dateComponts)!

        let weekdayIndex = (Calendar.current as NSCalendar).component(NSCalendar.Unit.weekday, from: targetDate)

        return weekdayIndex
     }


// MARK: - 指定日期为周几

   func getDayNameBy(stringDate: String) -> String{

       let df  = DateFormatter()

       df.dateFormat = "YYYY-MM-dd"

       let date = df.date(from: stringDate)!

       df.dateFormat = "EEEE"

       return df.string(from: date);

   }
    
//返回当前天的字符串

   func currentDayString()->String{

       let dateformatter = DateFormatter()

       dateformatter.dateFormat = "yyyy-MM-dd"

       let date = Date()

       return dateformatter.string(from: date)

   }
    
//返回月份的英文简写
    
   func monthString(_ Index: Int)->String{

       switch Index {
           case 1:
            return "Jan"
        
           case 2:
            return "Feb"
        
           case 3:
            return "Mar"
        
           case 4:
            return "Apr"
        
           case 5:
            return "May"
        
           case 6:
            return "Jun"
        
           case 7:
            return "Jul"
        
           case 8:
            return "Aug"
        
           case 9:
            return "Sep"
        
           case 10:
            return "Oct"
        
           case 11:
            return "Nov"
        
           case 12:
            return "Dec"
        
           default:
            return ""
       }
    }
}
