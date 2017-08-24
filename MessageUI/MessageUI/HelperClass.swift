//
//  CompareDate.swift
//  MessageUI
//
//  Created by Arun on 4/18/16.
//  Copyright © 2016 Arun. All rights reserved.
//

import Foundation

class HelperClass{
    
    static func compareTwoDates(date1: NSDate,date2: NSDate) -> Bool{


        let calendar = NSCalendar.currentCalendar()
        let components1 = calendar.components([.Day , .Month , .Year], fromDate: date1)
        let components2 = calendar.components([.Day , .Month , .Year], fromDate: date2)
        
        let year1 =  components1.year
        let month1 = components1.month
        let day1 = components1.day
        
        let year2 =  components2.year
        let month2 = components2.month
        let day2 = components2.day
        
        if (year1 == year2 && month1 == month2 && day1 == day2){
           return true
        }else{
            return false
        }
        
    }
    
    
    static func offsetFrom(date:NSDate) -> String {
        
        let currentDate = NSDate()
        
        let dayHourMinuteSecond: NSCalendarUnit = [.Day, .Hour, .Minute, .Second]
        let difference = NSCalendar.currentCalendar().components(dayHourMinuteSecond, fromDate: date, toDate: currentDate, options: [])
        
        let seconds = "\(difference.second)s"
        let minutes = "\(difference.minute)m" + " " + seconds
        let hours = "\(difference.hour)h" + " " + minutes
        let days = "\(difference.day)d" + " " + hours
        
        if difference.day    > 0 { return days }
        if difference.hour   > 0 { return hours }
        if difference.minute > 0 { return minutes }
        if difference.second > 0 { return seconds }
        return ""
    }
    
    
    static func offsetFromDays(date:NSDate) -> Int {
        
        let currentDate = NSDate()
        
        let dayHourMinuteSecond: NSCalendarUnit = [.Day]
        let difference = NSCalendar.currentCalendar().components(dayHourMinuteSecond, fromDate: date, toDate: currentDate, options: [])
        
        let days = difference.day
        
        if difference.day    > 0 { return days }
        return 0
    }
}

    
