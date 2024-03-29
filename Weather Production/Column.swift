//
//  Column.swift
//  Weather Production
//
//  Created by Semper Idem on 14-9-1.
//  Copyright (c) 2014年 1-xing. All rights reserved.
//
//  本类是常亮定义

import UIKit

//颜色常量定义
//let ColorRed:UIColor = UIColor(red: 255/255, green: 77/255, blue: 91/255, alpha: 1.0)
//let ColorOrange:UIColor = UIColor(red: 255/255, green: 167/255, blue: 43/255, alpha: 1.0)
//let ColorBlueFresh:UIColor = UIColor(red: 48/255, green: 218/255, blue: 255/255, alpha: 1.0)
//let ColorBlueAir:UIColor = UIColor(red: 47/255, green: 134/255, blue: 231/255, alpha: 1.0)
//let ColorBlueGrey:UIColor = UIColor(red: 121/255, green: 161/255, blue: 255/255, alpha: 1.0)
//let ColorBlueSky:UIColor = UIColor(red: 61/255, green: 158/255, blue: 255/255, alpha: 1.0)
//let ColorBlueDark:UIColor = UIColor(red: 1/255, green: 149/255, blue: 255/255, alpha: 1.0)

//晴
let 火红:UIColor = UIColor(red: 255/255, green: 77/255, blue: 91/255, alpha: 1.0)

//多云
let 靛青:UIColor = UIColor(red: 61/255, green: 158/255, blue: 255/255, alpha: 1.0)

//小雨、中雨、大雨、暴雨、大暴雨、特大暴雨、冻雨、阵雨、雷阵雨、雨夹雪、雷阵雨伴冰雹
let 蓝:UIColor = UIColor(red: 68/255, green: 206/255, blue: 246/255, alpha: 1.0)
let 藏青:UIColor = UIColor(red: 46/255, green: 78/255, blue: 126/255, alpha: 1.0)

//小雪、中雪、大雪、暴雪、阵雪、雾
let 霜色:UIColor = UIColor(red: 233/255, green: 241/255, blue: 246/255, alpha: 1.0)

//霾、沙尘暴、扬沙、浮尘
let 缃色:UIColor = UIColor(red: 255/255, green: 167/255, blue: 43/255, alpha: 1.0)

//阴天
let 墨灰:UIColor = UIColor(red: 117/255, green: 138/255, blue: 153/255, alpha: 1.0)

//城市代码及经纬度常量定义
let cityllinfo:Dictionary<String, String> = [
    "北京": "116.305145,39.982368",
    "上海": "121.43333,34.50000",
    "天津": "117.20000,39.13333",
    "香港": "114.10000,22.20000",
    "广州": "113.23333,23.16667",
    "珠海": "113.51667,22.30000",
    "深圳": "114.06667,22.61667",
    "杭州": "120.20000,30.26667",
    "重庆": "106.45000, 29.56667",
    "青岛": "120.33333,36.06667",
    "厦门": "118.10000,24.46667",
    "福州": "119.30000,26.08333",
    "兰州": "103.73333,36.03333",
    "贵阳": "106.71667,26.56667",
    "长沙": "113.00000,28.21667",
    "南京": "118.78333,32.05000",
    "南昌": "115.90000,28.68333",
    "沈阳": "123.38333,41.80000",
    "太原": "112.53333,37.86667",
    "成都": "104.06667,30.66667",
    "拉萨": "91.00000,29.60000",
    "乌鲁木齐": "87.68333,43.76667",
    "昆明": "102.73333,25.05000",
    "西安": "108.95000,34.26667",
    "西宁": "101.75000,36.56667",
    "银川": "106.26667,38.46667",
    "呼和浩特": "122.08333,46.06667",
    "哈尔滨": "126.63333,45.75000",
    "长春": "125.35000,43.88333",
    "武汉": "114.31667,30.51667",
    "郑州": "113.65000,34.76667",
    "石家庄": "114.48333,38.03333",
    "三亚": "109.50000,18.20000",
    "海口": "110.35000,20.01667",
    "澳门": "113.50000,22.20000"]

let citynuminfo:Dictionary<String, String> = [
    "北京": "101010100",
    "上海": "101020100",
    "天津": "101030100",
    "香港": "101320101",
    "广州": "101280101",
    "珠海": "101280701",
    "深圳": "101280601",
    "杭州": "101210101",
    "重庆": "101040100",
    "青岛": "101120201",
    "厦门": "101230201",
    "福州": "101230101",
    "兰州": "101160101",
    "贵阳": "101260101",
    "长沙": "101250101",
    "南京": "101190101",
    "南昌": "101240101",
    "沈阳": "101070101",
    "太原": "101100101",
    "成都": "101270101",
    "拉萨": "101140101",
    "乌鲁木齐": "101130101",
    "昆明": "101290101",
    "西安": "101110101",
    "西宁": "101150101",
    "银川": "101170101",
    "呼和浩特": "101080101",
    "哈尔滨": "101050101",
    "长春": "101060101",
    "武汉": "101200101",
    "郑州": "101180101",
    "石家庄": "101090101",
    "三亚": "101310201",
    "海口": "101310101",
    "澳门": "101330101"]

