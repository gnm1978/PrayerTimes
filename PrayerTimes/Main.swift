//
//  Main.swift
//  PrayerTimes
//
//  Created by Ghassan Mohammed on 1/12/15.
//  Copyright (c) 2015 Ghassan Mohammed. All rights reserved.
//

import Foundation

extension NSDate {
    var minute: Int { return NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitMinute, fromDate: self).minute }
    var hour:   Int { return NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitHour,   fromDate: self).hour   }
    var day:    Int { return NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitDay,    fromDate: self).day    }
    var month:  Int { return NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitMonth,  fromDate: self).month  }
    var year:   Int { return NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitYear,   fromDate: self).year   }
    func fireDateAt(hr:Int, min:Int) -> NSDate {
        if hr > NSDate().hour || (hr == NSDate().hour && min > NSDate().minute){
            return  NSCalendar.currentCalendar().dateWithEra(1, year: year, month: month, day: day, hour: hr, minute: min, second: 0, nanosecond: 0)!
        }
        return NSCalendar.currentCalendar().dateWithEra(1, year: year, month: month, day: day+1, hour: hour, minute: min, second: 0, nanosecond: 0)!
    }
}
