//
//  Current.swift
//  Stormy
//
//  Created by Jason Shiverick on 12/6/14.
//  Copyright (c) 2014 Treehouse. All rights reserved.
//

import Foundation
import UIkit

struct Current {
    
    var currentTime: String?
    var temperature: Int
    var humidity: Double
    var precipProbability: Double
    var summary: String
    var icon: UIImage?
    
    init(weatherDictionary: NSDictionary) {
        //Initalize shit here
        let currentWeather = weatherDictionary["currently"] as NSDictionary
        
        temperature = currentWeather["temperature"] as Int
        humidity = currentWeather["humidity"] as Double
        precipProbability = currentWeather["precipProbability"] as Double
        summary = currentWeather["summary"] as String

        currentTime = dateStringFromUnixTime(currentWeather["time"] as Int)
        
        icon = weatherIconFromString(currentWeather["icon"] as String)
        

    }
    
    
    func dateStringFromUnixTime(unixTime: Int) -> String {
        let timeInSeconds = NSTimeInterval(unixTime)
        
        let weatherDate = NSDate(timeIntervalSince1970: timeInSeconds)
        
        let dateFormater = NSDateFormatter()
        dateFormater.timeStyle = .ShortStyle
        
        return dateFormater.stringFromDate(weatherDate)
    }
    
    
    
    
    func weatherIconFromString(stringIcon: String) -> UIImage {
        var imageName: String
        
        switch stringIcon {
            case "clear-day":
                imageName = "clear-day"
            case "clear-night":
                imageName = "clear-night"
            case "rain":
                imageName = "rain"
            case "snow":
                imageName = "snow"
            case "sleet":
                imageName = "sleet"
            case "wind":
                imageName = "wind"
            case "fog":
                imageName = "fog"
            case "cloudy":
                imageName = "cloudy"
            case "partly-cloudy-day":
                imageName = "partly-cloudy"
            case "partly-cloudy-night":
                imageName = "cloudy-night"
            case "hail":
                imageName = "sleet"
            case "thunderstorm":
                imageName = "rain"
            case "tornado":
                imageName = "wind"
            default:
                imageName = "default"
        }
        
        var imageIcon = UIImage(named: imageName)
        return imageIcon!
    }
    
    
    
    
    
    
    
    
}