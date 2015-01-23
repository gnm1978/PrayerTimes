//
//  PrayTimesSechedul.swift
//  PrayerTimes
//
//  Created by Ghassan Mohammed on 1/17/15.
//  Copyright (c) 2015 Ghassan Mohammed. All rights reserved.
//

import UIKit
import CoreLocation

class PrayTimesSechedul: NSObject, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var pray = PrayTime()
    
    var current = CurrentDate()
        
    var prayArray : NSMutableArray {
        
        var methodNumber = NSUserDefaults.standardUserDefaults().integerForKey("MethodNumber")
        var asrMethodNumber = NSUserDefaults.standardUserDefaults().integerForKey("AsrMethodNumber")
        
        pray.setTimeFormat(0)
        pray.setCalcMethod(Int32(methodNumber))
        pray.setAsrMethod(Int32(asrMethodNumber))
        
        return pray.getDatePrayerTimes(current.year, andMonth: current.month, andDay: current.day, andLatitude: locationManager.location.coordinate.latitude, andLongitude: locationManager.location.coordinate.longitude, andtimeZone: pray.timeZone)
    
    }
    
    
        

    
    var fajr: NSDate {
        
        var hour : Int {
           var rangeHours : NSRange = NSMakeRange(2, 3)
           var hr = prayArray[0].stringByReplacingCharactersInRange(rangeHours, withString: "")
            println(prayArray)
            return hr.toInt()!
            
        }
        var minute : Int {
            var rangeMinutes : NSRange = NSMakeRange(0, 3)
            var mn = prayArray[0].stringByReplacingCharactersInRange(rangeMinutes, withString: "")
            return mn.toInt()!
        }
        var current = CurrentDate()
        
        var comp = NSDateComponents()
        comp.year = Int(current.year)
        comp.month = Int(current.month)
        comp.day = Int(current.day)
        comp.hour = hour
        comp.minute = minute
        
        var calender : NSCalendar = NSCalendar.autoupdatingCurrentCalendar()
        var fajr : NSDate = calender.dateFromComponents(comp)!
        
        
        return fajr
    }
    
    var sunrise: NSDate {

        var hour : Int {
            var rangeHours : NSRange = NSMakeRange(2, 3)
            var hr = prayArray[1].stringByReplacingCharactersInRange(rangeHours, withString: "")
            return hr.toInt()!
            
        }
        var minute : Int {
            var rangeMinutes : NSRange = NSMakeRange(0, 3)
            var mn = prayArray[1].stringByReplacingCharactersInRange(rangeMinutes, withString: "")
            return mn.toInt()!
        }

        var current = CurrentDate()
        
        var comp = NSDateComponents()
        //comp.timeZone = NSTimeZone.systemTimeZone()
        comp.year = Int(current.year)
        comp.month = Int(current.month)
        comp.day = Int(current.day)
        comp.hour = hour
        comp.minute = minute
        var calender : NSCalendar = NSCalendar.autoupdatingCurrentCalendar()
        var sunrise : NSDate = calender.dateFromComponents(comp)!
        
        return sunrise
    }
    var dhuhr: NSDate {

        var hour : Int {
            var rangeHours : NSRange = NSMakeRange(2, 3)
            var hr = prayArray[2].stringByReplacingCharactersInRange(rangeHours, withString: "")
            return hr.toInt()!
            
        }
        var minute : Int {
            var rangeMinutes : NSRange = NSMakeRange(0, 3)
            var mn = prayArray[2].stringByReplacingCharactersInRange(rangeMinutes, withString: "")
            return mn.toInt()!
        }

        var current = CurrentDate()
        
        var comp = NSDateComponents()
        //comp.timeZone = NSTimeZone.systemTimeZone()
        comp.year = Int(current.year)
        comp.month = Int(current.month)
        comp.day = Int(current.day)
        comp.hour = hour
        comp.minute = minute
        var calender : NSCalendar = NSCalendar.autoupdatingCurrentCalendar()
        var dhuhr : NSDate = calender.dateFromComponents(comp)!
        
        return dhuhr
    }
    
    var asr: NSDate {

        
        var hour : Int {
            var rangeHours : NSRange = NSMakeRange(2, 3)
            var hr = prayArray[3].stringByReplacingCharactersInRange(rangeHours, withString: "")
            return hr.toInt()!
            
        }
        var minute : Int {
            var rangeMinutes : NSRange = NSMakeRange(0, 3)
            var mn = prayArray[3].stringByReplacingCharactersInRange(rangeMinutes, withString: "")
            return mn.toInt()!
        }

        var current = CurrentDate()
        
        var comp = NSDateComponents()
        //comp.timeZone = NSTimeZone.systemTimeZone()
        comp.year = Int(current.year)
        comp.month = Int(current.month)
        comp.day = Int(current.day)
        comp.hour = hour
        comp.minute = minute
        var calender : NSCalendar = NSCalendar.autoupdatingCurrentCalendar()
        var asr : NSDate = calender.dateFromComponents(comp)!
        
        return asr
    }
    
    var maghrib: NSDate {
        

        
        var hour : Int {
            var rangeHours : NSRange = NSMakeRange(2, 3)
            var hr = prayArray[5].stringByReplacingCharactersInRange(rangeHours, withString: "")
            return hr.toInt()!
            
        }
        var minute : Int {
            var rangeMinutes : NSRange = NSMakeRange(0, 3)
            var mn = prayArray[5].stringByReplacingCharactersInRange(rangeMinutes, withString: "")
            return mn.toInt()!
        }

        var current = CurrentDate()
        
        var comp = NSDateComponents()
        //comp.timeZone = NSTimeZone.systemTimeZone()
        comp.year = Int(current.year)
        comp.month = Int(current.month)
        comp.day = Int(current.day)
        comp.hour = hour
        comp.minute = minute
        var calender : NSCalendar = NSCalendar.autoupdatingCurrentCalendar()
        var maghrib : NSDate = calender.dateFromComponents(comp)!
        
        return maghrib
    }
    
    var isha: NSDate {
        

        var hour : Int {
            var rangeHours : NSRange = NSMakeRange(2, 3)
            var hr = prayArray[6].stringByReplacingCharactersInRange(rangeHours, withString: "")
            return hr.toInt()!
            
        }
        var minute : Int {
            var rangeMinutes : NSRange = NSMakeRange(0, 3)
            var mn = prayArray[6].stringByReplacingCharactersInRange(rangeMinutes, withString: "")
            return mn.toInt()!
        }

        var current = CurrentDate()
        
        var comp = NSDateComponents()
        //comp.timeZone = NSTimeZone.systemTimeZone()
        comp.year = Int(current.year)
        comp.month = Int(current.month)
        comp.day = Int(current.day)
        comp.hour = hour
        comp.minute = minute
        var calender : NSCalendar = NSCalendar.autoupdatingCurrentCalendar()
        var isha : NSDate = calender.dateFromComponents(comp)!
        
        return isha
    }
    
    var test: NSDate {
        
        
        var hour : Int = 19
        var minute : Int = 22
        
        var current = CurrentDate()
        
        var comp = NSDateComponents()
        //comp.timeZone = NSTimeZone.systemTimeZone()
        comp.year = Int(current.year)
        comp.month = Int(current.month)
        comp.day = Int(current.day)
        comp.hour = hour
        comp.minute = minute
        var calender : NSCalendar = NSCalendar.autoupdatingCurrentCalendar()
        var test : NSDate = calender.dateFromComponents(comp)!
        
        return test
    }
    
}
