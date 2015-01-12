// Playground - noun: a place where people can play

import UIKit



class TimesOfPrayer: NSObject {
    
    var nextPrayerHours : Int?
    var nextPrayerMinutes : Int?
    
    var listOfPrayers : NSMutableArray = ["05:48","07:15","11:57","14:21","16:40","16:59","17:56"]
    
    func seperateHoursAndMinutes (arrayOfTime : [NSString]) -> (hours : [Int], minutes: [Int]) {
        
        
        for var i = 0; i < arrayOfTime.count; i++ {
            
            var hoursString = arrayOfTime[i].stringByReplacingCharactersInRange(2, withString: "")
            
            
        }
        
        return (hours : [Int](),  minutes : [Int]())
        
    }
    
}

var listOfPrayers : NSMutableArray = ["05:48","07:15","11:57","14:21","16:40","16:59","17:56"]


//func convertPrayArray (prayArray : NSMutableArray) ->(hourArray : [String], minuteArray : [String]) {
//    
//    var hours : [String] = [String]()
//    var minutes : [String] = [String]()
//
//for var i = 0; i < listOfPrayers.count; i++ {
//    
//    var rangeHours : NSRange = NSMakeRange(2, 3)
//    var rangeMinutes : NSRange = NSMakeRange(0, 3)
//    var hour = listOfPrayers[i].stringByReplacingCharactersInRange(rangeHours, withString: "")
//    hours.append(hour)
//    var minute = listOfPrayers[i].stringByReplacingCharactersInRange(rangeMinutes, withString: "")
//    minutes.append(minute)
//    
//    }
//    return (hours, minutes)
//}
//
//convertPrayArray(listOfPrayers)



func convertPrayArray (prayArray : NSMutableArray) ->(hourArray : NSMutableArray, minuteArray : NSMutableArray) {
    
    var hours : NSMutableArray = []
    var minutes : NSMutableArray = []
    
    for var i = 0; i < prayArray.count; i++ {
        
        var rangeHours : NSRange = NSMakeRange(2, 3)
        var rangeMinutes : NSRange = NSMakeRange(0, 3)
        var hour = prayArray[i].stringByReplacingCharactersInRange(rangeHours, withString: "")
        hours.addObject(hour)
        var minute = prayArray[i].stringByReplacingCharactersInRange(rangeMinutes, withString: "")
        minutes.addObject(minute)
        
    }
    return (hours, minutes)
}

var test = convertPrayArray(listOfPrayers)

println(test.hourArray[0])






