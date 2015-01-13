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


var formatter = NSDateFormatter()

formatter.dateFormat = "HH:mm"
var date : NSDate = formatter.dateFromString(listOfPrayers[5] as NSString)!

var secondFormatter = NSDateFormatter()
formatter.timeStyle = NSDateFormatterStyle.ShortStyle

var fajrTime = formatter.stringFromDate(date)


func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
    
    
    if(application.applicationState == UIApplicationState.Inactive) {
        
        println("Inactive");
        
        //Show the view with the content of the push
        // User opened the push notification
        completionHandler(UIBackgroundFetchResult.NewData);
        
    } else if (application.applicationState == UIApplicationState.Background) {
        
        println("Background");
        // User hasn't opened it, this was a silent update
        
        completionHandler(UIBackgroundFetchResult.NewData);
        
        
    } else {
        
        println("Active");
        
        //Show an in-app banner
        completionHandler(UIBackgroundFetchResult.NewData);
        
    }
    
}﻿









