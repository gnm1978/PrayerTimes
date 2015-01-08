//
//  CurrentDate.swift
//  PrayerTimes
//
//  Created by Ghassan Mohammed on 1/3/15.
//  Copyright (c) 2015 Ghassan Mohammed. All rights reserved.
//

import UIKit

class CurrentDate: NSObject {
    
    var currentDate = NSDate()
    var format = NSDateFormatter()
    
    var year : Int32 {
        
        format.dateFormat = "yyy"
        format.stringFromDate(currentDate)
        var currentYear = Int32(format.stringFromDate(currentDate) .toInt()!)
        return currentYear
    }
    
    
    var month : Int32 {
        
        format.dateFormat = "MM"
        format.stringFromDate(currentDate)
        var currentMonth = Int32(format.stringFromDate(currentDate) .toInt()!)
        return currentMonth
    }
    
    var day : Int32 {
        
        format.dateFormat = "dd"
        format.stringFromDate(currentDate)
        var currentDay = Int32(format.stringFromDate(currentDate) .toInt()!)
        return currentDay
    }

    
    
   
}
