//
//  TableViewController.swift
//  Weather Production
//
//  Created by Semper Idem on 14-8-31.
//  Copyright (c) 2014年 1-xing. All rights reserved.
//

import UIKit

class TableViewController:UITableViewController{
    @IBOutlet weak var 首页面: UIView!
    @IBOutlet weak var 次页面: UIView!
    @IBOutlet weak var 尾页面: UIView!
    @IBOutlet weak var 图像_天气: UIImageView!
    @IBOutlet weak var 标签_温度: UILabel!
    @IBOutlet weak var 标签_时间: UILabel!
    @IBOutlet weak var 标签_PM2_5: UILabel!
    @IBOutlet weak var 标签_星期: UILabel!
    @IBOutlet weak var 按钮_日期: UIButton!
    @IBOutlet weak var 按钮_菜单: UIButton!
    @IBOutlet weak var 按钮_城市: UIButton!
    
    var color:UIColor = 火红
    var chart:PDChart!
    
    var X轴第一个文字:NSString = ""
    var X轴第二个文字:NSString = ""
    var X轴第三个文字:NSString = ""
    var X轴第四个文字:NSString = ""
    var Y轴最高温度:NSString = ""
    var Y轴最低温度:NSString = ""
    var 今日天气最高温:Int = 0
    var 明日天气最高温:Int = 0
    var 后天天气最高温:Int = 0
    var 大后天天气最高温:Int = 0
    var 今日天气最低温:Int = 0
    var 明日天气最低温:Int = 0
    var 后天天气最低温:Int = 0
    var 大后天天气最低温:Int = 0
    var 天气最高温:Int = 0
    var 天气最低温:Int = 0
    
    override func viewDidLoad() {
        初始化()
        super.viewDidLoad()
        加载近日天气变化表()
        加载刷新指示器()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func 初始化(){
        self.首页面.backgroundColor = color
        self.次页面.backgroundColor = color
        self.尾页面.backgroundColor = color
        self.按钮_日期.titleLabel.textColor = color
        self.按钮_菜单.titleLabel.textColor = color
        self.按钮_城市.titleLabel.textColor = color
    }
    
    func 加载刷新指示器(){
        let refreshControl = UIRefreshControl()
        let attrDictionary:NSDictionary = NSDictionary(object: color, forKey: NSForegroundColorAttributeName)
        //设置标题颜色
        refreshControl.attributedTitle = NSAttributedString(string: "天气加载中……", attributes: attrDictionary) //定义归属标题
        
        refreshControl.tintColor = color  //设置刷新标志颜色
        refreshControl.addTarget(self, action: "刷新操作", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refreshControl
    }
    
    func 刷新操作(){
        self.refreshControl.beginRefreshing()

        读取天气数据()
        self.首页面.backgroundColor = color
        self.次页面.backgroundColor = color
        self.尾页面.backgroundColor = color
        按钮_日期.titleLabel.textColor = color
        按钮_菜单.titleLabel.textColor = color
        按钮_城市.titleLabel.textColor = color
        refreshControl.tintColor = color
        let attrDictionary:NSDictionary = NSDictionary(object: color, forKey: NSForegroundColorAttributeName)
        //设置标题颜色
        refreshControl.attributedTitle = NSAttributedString(string: "天气加载中……", attributes: attrDictionary)
        self.refreshControl.endRefreshing()
        加载近日天气变化表()
    }
    
    func 读取天气数据(){
        var cityinfoForBaiduAPI:String = cityllinfo["北京"]!
        var cityinfoForCNAPI:String = citynuminfo["北京"]!
        
        var URL = NSURL(string: "http://api.map.baidu.com/telematics/v3/weather?location=\(cityinfoForBaiduAPI)&output=json&ak=IPfP2ScAAjO0Yjs48Lc15k2B") //百度天气预报API
        var cnURL = NSURL(string: "http://www.weather.com.cn/data/sk/\(cityinfoForCNAPI).html")
        
        var Data = NSData.dataWithContentsOfURL(URL, options: NSDataReadingOptions.DataReadingUncached, error: nil)
        var cnData = NSData.dataWithContentsOfURL(cnURL, options: NSDataReadingOptions.DataReadingUncached, error: nil)
        
        var json: AnyObject! = NSJSONSerialization.JSONObjectWithData(Data, options: NSJSONReadingOptions.AllowFragments, error: nil)
        var cnjson: AnyObject! = NSJSONSerialization.JSONObjectWithData(cnData, options: NSJSONReadingOptions.AllowFragments, error: nil)
        
        var datenow: AnyObject! = json.objectForKey("date") //获取当前时间，年-月-日
        var yearnow = (datenow.substringToIndex(4) as NSString).integerValue //获取当前年份
        var monthnow = (datenow.substringWithRange(NSRange(location: 5, length: 2)) as NSString).integerValue //获取当前月份
        var daynow = (datenow.substringWithRange(NSRange(location: 8, length: 2)) as NSString).integerValue //获取当前日期
        
        var resultsJson: AnyObject! = (json.objectForKey("results") as NSArray)[0] //天气预报信息，白天可返回近期3天的天气情况（今天、明天、后天）、晚上可返回近期4天的天气情况（今天、明天、后天、大后天）
        
        var weather_data: [AnyObject] = []
        var date: [AnyObject] = []       //天气预报时间
        var temperature: [AnyObject] = [] //温度，温度范围，如：29～22℃
        var weather: [AnyObject] = [] //天气状况，常见天气情况（“|”分隔符）：晴|多云|阴|阵雨|雷阵雨|雷阵雨伴有冰雹|雨夹雪|小雨|中雨|大雨|暴雨|大暴雨|特大暴雨|阵雪|小雪|中雪|大雪|暴雪|雾|冻雨|沙尘暴|小雨转中雨|中雨转大雨|大雨转暴雨|暴雨转大暴雨|大暴雨转特大暴雨|小雪转中雪|中雪转大雪|大雪转暴雪|浮尘|扬沙|强沙尘暴|霾
        
        var weatherinfo: AnyObject! = cnjson.objectForKey("weatherinfo")
        
        for i in 0...3 {
            weather_data.append((resultsJson.objectForKey("weather_data") as NSArray)[i])
            date.append(weather_data[i].objectForKey("date")!)
            temperature.append(weather_data[i].objectForKey("temperature")!)
            weather.append(weather_data[i].objectForKey("weather")!)
        }
        
        var 当前温度: AnyObject! = weatherinfo.objectForKey("temp")       //当前温度
        var 湿度: AnyObject! = weatherinfo.objectForKey("SD")           //湿度
        var 风向: AnyObject! = weatherinfo.objectForKey("WD")           //风向
        var 风速: AnyObject! = weatherinfo.objectForKey("WS")           //风速
        var 今日天气: AnyObject! = weather[0]                          //今日天气
        var 今日星期: AnyObject! = (date[0]).substringToIndex(2)      //今日星期
        var pm2_5: AnyObject! = resultsJson.objectForKey("pm25")        //PM2.5
        
        var timenow:NSDate = NSDate()
        var calendar:NSCalendar = NSCalendar.currentCalendar()
        var comps:NSDateComponents = calendar.components(NSCalendarUnit.MonthCalendarUnit | NSCalendarUnit.DayCalendarUnit | NSCalendarUnit.HourCalendarUnit | NSCalendarUnit.MinuteCalendarUnit , fromDate: timenow)
        
        标签_温度.text = "\(当前温度)°"
        if comps.minute < 10{
            标签_时间.text =  "\(comps.hour):0\(comps.minute)"
        }
        else{
            标签_时间.text = "\(comps.hour):\(comps.minute)"
        }
        标签_PM2_5.text = "\(pm2_5)"
    
        图像_天气.image = UIImage(named: "\(今日天气).png")
        标签_星期.text = "\(今日星期)"
        按钮_日期.titleLabel.textColor = color
        按钮_菜单.titleLabel.textColor = color
        按钮_城市.titleLabel.textColor = color
        
        switch 今日天气 as String{
        case "晴":
            color = 火红
        case "多云":
            color = 靛青
        case "小雨", "中雨", "大雨","暴雨","大暴雨","特大暴雨","冻雨","阵雨","雷阵雨","雨夹雪","雷阵雨伴冰雹":
            color = 蓝
        case "小雪","中雪","大雪","暴雪'","阵雪","雾":
            color = 霜色
        case "霾","沙尘暴","扬沙","浮尘":
            color = 缃色
        default:
            color = 墨灰
        }
        
        var 明日天气:AnyObject! = weather[1]
        var 后天天气:AnyObject! = weather[2]
        var 大后天天气:AnyObject! = weather[3]
        
        var 明日星期:AnyObject! = date[1]
        var 后天星期:AnyObject! = date[2]
        var 大后天星期:AnyObject! = date[3]
        
        今日天气最高温 = ("\(temperature[0])" as NSString).substringToIndex(2).toInt()!
        明日天气最高温 = ("\(temperature[1])" as NSString).substringToIndex(2).toInt()!
        后天天气最高温 = ("\(temperature[2])" as NSString).substringToIndex(2).toInt()!
        大后天天气最高温 = ("\(temperature[3])" as NSString).substringToIndex(2).toInt()!
        今日天气最低温 = ("\(temperature[0])" as NSString).substringWithRange(NSRange(location: 5, length: 2)).toInt()!
        明日天气最低温 = ("\(temperature[1])" as NSString).substringWithRange(NSRange(location: 5, length: 2)).toInt()!
        后天天气最低温 = ("\(temperature[2])" as NSString).substringWithRange(NSRange(location: 5, length: 2)).toInt()!
        大后天天气最低温 = ("\(temperature[3])" as NSString).substringWithRange(NSRange(location: 5, length: 2)).toInt()!
        
        X轴第一个文字 = "\(今日星期)"
        X轴第二个文字 = "\(明日星期)"
        X轴第三个文字 = "\(后天星期)"
        X轴第四个文字 = "\(大后天星期)"
        
        天气最高温 = 今日天气最高温
        if 天气最高温 < 明日天气最高温 {
            天气最高温 = 明日天气最高温
        }
        else if 天气最高温 < 后天天气最高温 {
            天气最高温 = 后天天气最高温
        }
        else if 天气最高温 < 大后天天气最高温 {
            天气最高温 = 大后天天气最高温
        }
        天气最高温 += 5
        
        天气最低温 = 今日天气最低温
        if 天气最低温 < 明日天气最低温 {
            天气最低温 = 明日天气最低温
        }
        else if 天气最低温 < 后天天气最低温 {
            天气最低温 = 后天天气最低温
        }
        else if 天气最低温 < 大后天天气最低温 {
            天气最低温 = 大后天天气最低温
        }
        天气最低温 += 5
    }
    
    
    func 加载近日天气变化表(){
        var lineChart: PDLineChart = getLineChart()
        lineChart.backgroundColor = color
        lineChart.dataItem.chartFillColor = color
        chart = lineChart
        self.次页面.addSubview(lineChart)
        chart.strokeChart()
    }
    
    func getLineChart() -> PDLineChart {
        var dataItem: PDLineChartDataItem = PDLineChartDataItem()
        dataItem.xMax = 4.0
        dataItem.xInterval = 1.0
        dataItem.yMax = 40.0
        dataItem.yInterval = 4.0
        dataItem.pointArray = [CGPoint(x: 1.0, y: 今日天气最高温), CGPoint(x: 2.0, y: 明日天气最高温), CGPoint(x: 3.0, y: 后天天气最高温), CGPoint(x: 4.0, y: 大后天天气最高温) ]
        dataItem.xAxesDegreeTexts = ["\(X轴第一个文字)", "\(X轴第二个文字)", "\(X轴第三个文字)","\(X轴第四个文字)"]
        dataItem.yAxesDegreeTexts = ["-5", "0", "5", "10", "15", "20", "25", "30", "35", "40"]
        
        var lineChart: PDLineChart = PDLineChart(frame: CGRectMake(-15, 0, 350, 350), dataItem: dataItem)
        return lineChart
    }
    
}