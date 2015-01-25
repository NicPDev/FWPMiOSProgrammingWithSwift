//
//  TableViewCellModel.swift
//  Weather
//
//  Created by student on 18.01.15.
//  Copyright (c) 2015 NicolasPfeuffer. All rights reserved.
//

import UIKit

class TableViewCellModel: NSObject {
   
    
    enum WeatherMain: String {
        case Rain = "Rainy"
        case Clouds = "Cloudy"
        case Sun = "Sunny"
        case SunnyWithClouds = "SunnyWithClouds"
        var img: UIImage {
            return UIImage(named: self.rawValue)!
        }
    }
    
    var rawDate:NSDate = NSDate()
    var date:String = String()
    var maxTemp:String = String()
    var minTemp:String = String()
    var icon:String = String()
    let weatherIcon:WeatherMain
    
    
    
    init (weatherDate:Int, weatherMaxTemp:Double, weatherMinTemp:Double, weatherIcon:String) {
        
        var format = NSNumberFormatter()
        format.numberStyle = .DecimalStyle
        format.maximumIntegerDigits = 3
        format.maximumFractionDigits = 0
        format.roundingMode = .RoundUp
        
        var formatter:NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        self.rawDate = NSDate(timeIntervalSince1970: NSTimeInterval(weatherDate))
        self.date = formatter.stringFromDate(self.rawDate)
        
        self.maxTemp = format.stringFromNumber(weatherMaxTemp - 273.15)!
        self.minTemp = format.stringFromNumber(weatherMinTemp - 273.15)!
        switch weatherIcon {
        case "Rain":
            self.weatherIcon = .Rain
        case "Clouds":
            self.weatherIcon = .Clouds
        case "Sun":
            self.weatherIcon = .Sun
        default:
            self.weatherIcon = WeatherMain.SunnyWithClouds
    
    
    }
    }
}