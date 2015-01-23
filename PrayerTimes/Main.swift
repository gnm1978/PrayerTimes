//
//  Main.swift
//  PrayerTimes
//
//  Created by Ghassan Mohammed on 1/12/15.
//  Copyright (c) 2015 Ghassan Mohammed. All rights reserved.
//

import Foundation
public extension NSDate {
    func xDays(x:Int) -> NSDate {
        return NSCalendar.currentCalendar().dateByAddingUnit(.CalendarUnitDay, value: x, toDate: self, options: nil)!
    }
    var day:            Int { return NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitDay,           fromDate: self).day           }
    var month:          Int { return NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitMonth,         fromDate: self).month         }
    var year:           Int { return NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitYear,          fromDate: self).year          }
    var fireDateAt7am: NSDate    { return NSCalendar.currentCalendar().dateWithEra(1, year: year, month: month, day: day, hour: 0, minute: 0, second: 0, nanosecond: 0)! }
    var fireDateAt8am: NSDate    { return NSCalendar.currentCalendar().dateWithEra(1, year: year, month: month, day: day, hour: 0, minute: 0, second: 0, nanosecond: 0)! }
    func fireDateAt(hr:Int, min:Int) -> NSDate {
        return NSCalendar.currentCalendar().dateWithEra(1, year: year, month: month, day: day, hour: hr, minute: min, second: 0, nanosecond: 0)!
    }
}
