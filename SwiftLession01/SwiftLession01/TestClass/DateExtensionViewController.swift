//
//  DateExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/3/11.
//

import UIKit

class DateExtensionViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        headDataArray = ["一、Date 基本的扩展", "二、时间格式的转换", "三、前天、昨天、今天、明天、后天、是否同一年同一月同一天 的判断", "四、相对的时间变化", "五、某年月份的天数获取"]
        dataArray = [["获取当前 秒级 时间戳 - 10 位", "获取当前 毫秒级 时间戳 - 13 位", "获取当前的时间 Date", "从 Date 获取年份", "从 Date 获取月份", "从 Date 获取 日", "从 Date 获取 小时", "从 Date 获取 分钟", "从 Date 获取 秒", "从 Date 获取 毫秒", "从日期获取 星期(英文)", "从日期获取 星期(中文)", "从日期获取 月(英文)"], ["时间戳(支持10位和13位)按照对应的格式 转化为 对应时间的字符串 如：1603849053 按照 yyyy-MM-dd HH:mm:ss 转化后为：2020-10-28 09:37:33", "时间戳(支持 10 位 和 13 位) 转 Date", "Date 转换为相应格式的字符串", "带格式的时间转 时间戳，支持返回 13位 和 10位的时间戳，时间字符串和时间格式必须保持一致", "带格式的时间转 Date", "秒转换成播放时间条的格式", "Date 转 时间戳"], ["今天的日期", "昨天的日期", "明天的日期", "前天的日期", "后天的日期", "是否为今天（只比较日期，不比较时分秒）", "是否为昨天", "是否为前天", "是否为今年", "两个date是否为同一年同一月的同一天", "当前日期是不是润年", "是否为本周"], ["取得与当前时间的间隔差", "获取两个日期之间的数据", "获取两个日期之间的天数", "获取两个日期之间的小时", "获取两个日期之间的分钟", "获取两个日期之间的秒数"], ["获取某一年某一月的天数", "获取当前月的天数"]]
    }
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

// MARK: - 五、某年月份的天数获取
extension DateExtensionViewController {
    
    // MARK: 5.2、获取当前月的天数
    @objc func test52() {
        print("获取当前月的天数是：\(Date.jx.currentMonthDays())")
    }
    
    // MARK: 5.1、获取某一年某一月的天数
    @objc func test51() {
        print("获取某一年某一月的天数", "1992年2月的天数是：\(Date.jx.daysCount(year: 1992, month: 2))")
    }
}

// MARK: - 四、相对的时间变化
extension DateExtensionViewController {
    // MARK: 4.6、获取两个日期之间的秒数
    @objc func test46() {
        // 2021-06-23 14:09:06
        let timestamp1 = "1624428546"
        let date1 = Date.jx.timestampToFormatterDate(timestamp: timestamp1)
        // 2021-06-21 10:00:00
        let timestamp2 = "1624240800"
        let date2 = Date.jx.timestampToFormatterDate(timestamp: timestamp2)
        print("获取两个日期之间的秒数", "时间：\(date1)", "时间：\(date1) ", "两个日期之间的秒数：\(date1.jx.numberOfSeconds(from: date2) ?? 0)")
    }
    
    // MARK: 4.5、获取两个日期之间的分钟
    @objc func test45() {
        // 2021-06-23 14:09:06
        let timestamp1 = "1624428546"
        let date1 = Date.jx.timestampToFormatterDate(timestamp: timestamp1)
        // 2021-06-21 10:00:00
        let timestamp2 = "1624240800"
        let date2 = Date.jx.timestampToFormatterDate(timestamp: timestamp2)
        print("获取两个日期之间的分钟", "时间：\(date1)", "时间：\(date1) ", "两个日期之间的分钟：\(date1.jx.numberOfMinutes(from: date2) ?? 0)")
    }
    
    // MARK: 4.4、获取两个日期之间的小时
    @objc func test44() {
        // 2021-06-23 14:09:06
        let timestamp1 = "1624428546"
        let date1 = Date.jx.timestampToFormatterDate(timestamp: timestamp1)
        // 2021-06-21 10:00:00
        let timestamp2 = "1624240800"
        let date2 = Date.jx.timestampToFormatterDate(timestamp: timestamp2)
        print("获取两个日期之间的小时", "时间：\(date1)", "时间：\(date1) ", "两个日期之间的小时：\(date1.jx.numberOfHours(from: date2) ?? 0)")
    }
    
    // MARK: 4.3、获取两个日期之间的天数
    @objc func test43() {
        // 2021-06-23 14:09:06
        let timestamp1 = "1624428546"
        let date1 = Date.jx.timestampToFormatterDate(timestamp: timestamp1)
        // 2021-06-21 10:00:00
        let timestamp2 = "1624240800"
        let date2 = Date.jx.timestampToFormatterDate(timestamp: timestamp2)
        print("获取两个日期之间的天数", "时间：\(date1)", "时间：\(date1) ", "两个日期之间的天数：\(date1.jx.numberOfDays(from: date2) ?? 0)")
    }
    
    // MARK: 4.2、获取两个日期之间的数据
    @objc func test42() {
        // 2021-06-23 14:09:06
        let timestamp1 = "1624428546"
        let date1 = Date.jx.timestampToFormatterDate(timestamp: timestamp1)
        // 2021-06-21 10:00:00
        let timestamp2 = "1624240800"
        let date2 = Date.jx.timestampToFormatterDate(timestamp: timestamp2)
        print("获取两个日期之间的数据", "时间：\(date1)", "时间：\(date1) ", "两个日期之间的数据：\(date1.jx.componentCompare(from: date2))")
    }
    
    // MARK: 4.1、取得与当前时间的间隔差
    @objc func test41() {
        // 2020-10-26 09:37:33
        let timestamp1 = "1603676253"
        let date1 = Date.jx.timestampToFormatterDate(timestamp: timestamp1)
        print("取得与当前时间的间隔差", "\(date1) 与当前时间的间隔差：\(date1.jx.callTimeAfterNow())")
    }
}

// MARK: - 三、前天、昨天、今天、明天、后天、是否同一年同一月同一天 的判断
extension DateExtensionViewController {
    
    // MARK: 3.12、是否为本周
    @objc func test312() {
        // 2021-06-23 14:09:06
        let timestamp = "1624428546"
        let date = Date.jx.timestampToFormatterDate(timestamp: timestamp)
        let timestamp2 = "1629104010"
        let date2 = Date.jx.timestampToFormatterDate(timestamp: timestamp2)
        print("是否为本周", "日期：\(date)", "是否为本周: \(date.jx.isThisWeek)", "日期：\(date2)", "是否为本周: \(date2.jx.isThisWeek)")
    }
    
    // MARK: 3.11、当前日期是不是润年
    @objc func test311() {
        // 2021-06-23 14:09:06
        let timestamp = "1624428546"
        let date = Date.jx.timestampToFormatterDate(timestamp: timestamp)
        print("当前日期是不是润年", "日期：\(date)", "是不是润年: \(date.jx.isLeapYear)")
    }
    
    // MARK: 3.10、两个date是否为同一年同一月的同一天
    @objc func test310() {
        // 2020-10-26 09:37:33
        let timestamp1 = "1572053853"
        let date1 = Date.jx.timestampToFormatterDate(timestamp: timestamp1)
        // 2019-10-26 09:37:33
        let timestamp2 = "1572053853"
        let date2 = Date.jx.timestampToFormatterDate(timestamp: timestamp2)
        print("是否为同一年同一月的同一天", "\(date1)", "\(date2)", "结果：\(date1.jx.isSameDay(date: date2))")
    }
    
    // MARK: 3.9、是否为今年
    @objc func test39() {
        // 2020-10-26 09:37:33
        let timestamp1 = "1603676253"
        let date1 = Date.jx.timestampToFormatterDate(timestamp: timestamp1)
        // 2019-10-26 09:37:33
        let timestamp2 = "1572053853"
        let date2 = Date.jx.timestampToFormatterDate(timestamp: timestamp2)
        print("是否为今年的判断", "\(date1) 是否为今年：\(date1.jx.isThisYear)", "\(date2) 是否为今年：\(date2.jx.isThisYear)")
    }
    
    // MARK: 3.8、是否为前天
    @objc func test38() {
        // 2020-10-26 09:37:33
        let timestamp1 = "1603676253"
        let date = Date.jx.timestampToFormatterDate(timestamp: timestamp1)
        print("今天：\(date)", "是否为前天：\(date.jx.isTheDayBeforeYesterday)")
    }
    
    // MARK: 3.7、是否为昨天
    @objc func test37() {
        let timestamp1 = "1603762653"
        let date = Date.jx.timestampToFormatterDate(timestamp: timestamp1)
        print("是否为昨天", "\(date) 是否为昨天 \(date.jx.isYesterday)")
    }
    
    // MARK: 3.6、是否为今天（只比较日期，不比较时分秒）
    @objc func test36() {
        let timestamp1 = "1603849053"
        let date = Date.jx.timestampToFormatterDate(timestamp: timestamp1)
        print("是否为今天（只比较日期，不比较时分秒）", "\(date) 是否为今天 \(date.jx.isToday)")
    }
    
    // MARK: 3.5、后天的日期
    @objc func test35() {
        guard let date = Date.jx.theDayAfterYesterDayDate else {
            return
        }
        print("后天的日期：\(date)")
    }
    
    // MARK: 3.4、前天的日期
    @objc func test34() {
        guard let date = Date.jx.theDayBeforYesterDayDate else {
            return
        }
        print("前天的日期：\(date)")
    }
    
    // MARK: 3.3、明天的日期
    @objc func test33() {
        guard let date = Date.jx.tomorrowDate else {
            return
        }
        print("明天的日期：\(date)")
    }
    
    // MARK: 3.2、昨天的日期
    @objc func test32() {
        guard let date = Date.jx.yesterDayDate else {
            return
        }
        print("昨天的日期：\(date)")
    }
    
    // MARK: 3.1、今天的日期
    @objc func test31() {
        print("今天的日期：\(Date.jx.todayDate)")
    }
}

// MARK: - 二、时间格式的转换
extension DateExtensionViewController {
    
    // MARK: 2.7、Date 转 时间戳
    @objc func test27() {
        let timeStr = "2020-10-28 09:37:33"
        let timestamp1Fomatter = "yyyy-MM-dd HH:mm:ss"
        let date = Date.jx.formatterTimeStringToDate(timesString: timeStr, formatter: timestamp1Fomatter)
        let timestamp = date.jx.dateFromGMT().jx.dateToTimeStamp(timestampType: .second)
        let newTimeStr = Date.jx.timestampToFormatterTimeString(timestamp: timestamp, format: "yyyy-MM-dd HH:mm:ss")
        print("Date 转 时间戳" ,"\(date)：转 时间戳：\(timestamp) -> \(newTimeStr)")
    }
    
    // MARK: 2.6、秒转换成播放时间条的格式
    @objc func test26() {
        let second: Int = 3726
        let second2: Int = 1928
        let second3: Int = 28
        print("秒转换成播放时间条的格式，\(second)秒 1时2分6秒", "秒类型：\(Date.jx.getFormatPlayTime(seconds: second, type: .second))", "分钟类型：\(Date.jx.getFormatPlayTime(seconds: second, type: .minute))", "小时类型：\(Date.jx.getFormatPlayTime(seconds: second, type: .hour))", "自动类型：\(Date.jx.getFormatPlayTime(seconds: second, type: .normal))", "秒转换成播放时间条的格式，\(second2)秒 32分8秒", "秒类型：\(Date.jx.getFormatPlayTime(seconds: second2, type: .second))", "分钟类型：\(Date.jx.getFormatPlayTime(seconds: second2, type: .minute))", "小时类型：\(Date.jx.getFormatPlayTime(seconds: second2, type: .hour))", "自动类型：\(Date.jx.getFormatPlayTime(seconds: second2, type: .normal))", "秒转换成播放时间条的格式，\(second3)秒 28秒", "秒类型：\(Date.jx.getFormatPlayTime(seconds: second3, type: .second))", "分钟类型：\(Date.jx.getFormatPlayTime(seconds: second3, type: .minute))", "小时类型：\(Date.jx.getFormatPlayTime(seconds: second3, type: .hour))", "自动类型：\(Date.jx.getFormatPlayTime(seconds: second3, type: .normal))")
    }
    
    // MARK: 2.5、带格式的时间转 Date
    @objc func test25() {
        let timesString1 = "2020-10-28"
        let timestamp1Fomatter = "yyyy-MM-dd"
        let date1 = Date.jx.formatterTimeStringToDate(timesString: timesString1, formatter: timestamp1Fomatter)
        let timestamp1 = date1.jx.dateToTimeStamp(timestampType: .second)
        
        let timesString2 = "2020年10月28日"
        let timestamp2Fomatter = "yyyy年MM月dd日"
        let date2 = Date.jx.formatterTimeStringToDate(timesString: timesString2, formatter: timestamp2Fomatter)
        let timestamp2 = date2.jx.dateToTimeStamp(timestampType: .second)
        
        let timesString3 = "2020-10-28 09:37:33"
        let timestamp3Fomatter = "yyyy-MM-dd HH:mm:ss"
        let date3 = Date.jx.formatterTimeStringToDate(timesString: timesString3, formatter: timestamp3Fomatter)
        let timestamp3 = date3.jx.dateToTimeStamp(timestampType: .second)
        
        print("带格式的时间转 Date", "\(timesString1) -> \(date1) -> \(timestamp1)", "\(timesString2) -> \(date2) -> \(timestamp2)","\(timesString3) -> \(date3) -> \(timestamp3)")
    }
    
    // MARK: 2.4、带格式的时间转 时间戳，支持返回 13位 和 10位的时间戳，时间字符串和时间格式必须保持一致
    @objc func test24() {
        let timeStr1 = "2020-10-28"
        let timestamp1Fomatter = "yyyy-MM-dd"
        let timestamp1 = Date.jx.formatterTimeStringToTimestamp(timesString: timeStr1, formatter: timestamp1Fomatter, timestampType: .second)
        let timeNewStr1 = Date.jx.timestampToFormatterTimeString(timestamp: timestamp1, format: "yyyy-MM-dd HH:mm:ss")
        
        let timeStr2 = "2020年10月28日"
        let timestamp2Fomatter = "yyyy年MM月dd日"
        let timestamp2 = Date.jx.formatterTimeStringToTimestamp(timesString: timeStr2, formatter: timestamp2Fomatter, timestampType: .millisecond)
        let timeNewStr2 = Date.jx.timestampToFormatterTimeString(timestamp: timestamp2, format: "yyyy-MM-dd HH:mm:ss")
        
        let timeStr3 = "2020-10-28 09:37:33"
        let timestamp3Fomatter = "yyyy-MM-dd HH:mm:ss"
        let timestamp3 = Date.jx.formatterTimeStringToTimestamp(timesString: timeStr3, formatter: timestamp3Fomatter, timestampType: .second)
        let timeNewStr3 = Date.jx.timestampToFormatterTimeString(timestamp: timestamp3, format: "yyyy-MM-dd HH:mm:ss")
        
        print("时间戳 转 Date, 支持 10 位 和 13 位：", "\(timeStr1) -> \(timestamp1) -> \(timeNewStr1)", "\(timeStr2) -> \(timestamp2) -> \(timeNewStr2)", "\(timeStr3) -> \(timestamp3) -> \(timeNewStr3)")
    }
    
    // MARK: 2.3、Date 转换为相应格式的字符串
    @objc func test23() {
        /// 2020-10-28 09:37:33+
        let timestamp = "1603849053"
        let date = Date.jx.timestampToFormatterDate(timestamp: timestamp)
        print("时间戳：\(timestamp)(2020-10-28 09:37:33) 转为Date为：\(date)", "date 转 时间yyyy-MM-dd HH:mm:ss格式的时间为：\(date.jx.toformatterTimeString(formatter: "yyyy-MM-dd HH:mm:ss"))")
    }
    
    // MARK: 2.2、时间戳(支持 10 位 和 13 位) 转 Date
    @objc func test22() {
        let timestamp1 = "1603849053"
        let date1 = Date.jx.timestampToFormatterDate(timestamp: timestamp1)
        let timestampStr1 = date1.jx.dateToTimeStamp(timestampType: .second)
        
        let timestamp2 = "1603849053000"
        let date2 = Date.jx.timestampToFormatterDate(timestamp: timestamp2)
        let timestampStr2 = date2.jx.dateToTimeStamp(timestampType: .millisecond)
        
        print("时间戳(支持 10 位 和 13 位) 转 Date：", "\(timestamp1) -> \(date1) -> \(timestampStr1)", "\(timestamp2) -> \(date2) -> \(timestampStr2)")
    }
    
    // MARK: 2.1、时间戳(支持10位和13位)按照对应的格式 转化为 对应时间的字符串 如：1603849053 按照 "yyyy-MM-dd HH:mm:ss" 转化后为：2020-10-28 09:37:33
    @objc func test21() {
        let timestamp1 = "1603849053"
        let timestamp2 = "1603849053000"
        print("时间戳 按照对应的格式 转化为 对应时间的字符串，支持10位 和 13位 ：", "\(timestamp1) -> \(Date.jx.timestampToFormatterTimeString(timestamp: timestamp1, format: "yyyy-MM-dd HH:mm:ss"))", "\(timestamp2) -> \(Date.jx.timestampToFormatterTimeString(timestamp: timestamp2, format: "yyyy-MM-dd HH:mm:ss"))")
    }
}

// MARK: - 一、Date 基本的扩展
extension DateExtensionViewController {
    
    // MARK: 1.13、从日期获取 月(英文)
    @objc func test113() {
        let date = Date.jx.currentDate
        print("从日期获取 月(英文)", "\(date) 的 月 为：\(date.jx.monthAsString)")
    }
    
    // MARK: 1.12、从日期获取 星期(中文)
    @objc func test112() {
        let date = Date.jx.currentDate
        // 2021-08-18 16:53:30 星期三
        let timestamp1 = "1629276810"
        let date2 = Date.jx.timestampToFormatterDate(timestamp: timestamp1)
        print("从日期获取 星期(中文)", "\(date) 的 星期 为：\(date.jx.weekdayStringFromDate)", "\(date2) 的 星期 为：\(date2.jx.weekdayStringFromDate)")
    }
    
    // MARK: 1.11、从日期获取 星期(英文)
    @objc func test111() {
        let date = Date.jx.currentDate
        print("从日期获取 星期", "\(date) 的 星期 为：\(date.jx.weekday)")
    }
    
    // MARK: 1.10、从 Date 获取 毫秒
    @objc func test110() {
        let date = Date.jx.currentDate
        print("从日期获取 毫秒", "\(date) 的 毫秒 为：\(date.jx.nanosecond)")
    }
    
    // MARK: 1.9、从 Date 获取 秒
    @objc func test19() {
        let date = Date.jx.currentDate
        print("从日期获取 秒", "\(date) 的 秒 为：\(date.jx.second)")
    }
    
    // MARK: 1.8、从 Date 获取 分钟
    @objc func test18() {
        let date = Date.jx.currentDate
        print("从日期获取 分钟", "\(date) 的 分钟 为：\(date.jx.minute)")
    }
    
    // MARK: 1.7、从 Date 获取 小时
    @objc func test17() {
        let date = Date.jx.currentDate
        print("从日期获取 小时", "\(date) 的 小时 为：\(date.jx.hour)")
    }
    
    // MARK: 1.6、从日期获取 日
    @objc func test16() {
        let date = Date.jx.currentDate
        print("从日期获取 日", "\(date) 的 日 为：\(date.jx.day)")
    }
    
    // MARK: 1.5、从 Date 获取月份
    @objc func test15() {
        let date = Date.jx.currentDate
        print("从日期获取 日", "\(date) 的 日 为：\(date.jx.day)")
    }
    
    // MARK: 1.4、从日期获取年份
    @objc func test14() {
        let date = Date.jx.currentDate
        print("从日期获取年份位", "\(date) 的 年份为：\(date.jx.year)")
    }
    
    // MARK: 1.3、获取当前的时间 Date
    @objc func test13() {
        let date = Date.jx.currentDate
        print("获取当前的时间 Date位：\(date)","当前的 date 转 时间为：\(date.jx.toformatterTimeString(formatter: "yyyy-MM-dd"))")
    }
    
    // MARK: 1.2、获取当前 毫秒级 时间戳 - 13 位
    @objc func test12() {
        print("获取当前 毫秒级 时间戳 - 13 位：\(Date.jx.milliStamp)")
    }
    
    // MARK: 1.1、获取当前 秒级 时间戳 - 10 位
    @objc func test11() {
        print("获取当前 秒级 时间戳 - 10 位：\(Date.jx.secondStamp)")
    }
}

