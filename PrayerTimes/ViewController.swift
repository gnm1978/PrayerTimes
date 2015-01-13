//
//  ViewController.swift
//  PrayerTimes
//
//  Created by Ghassan Mohammed on 12/23/14.
//  Copyright (c) 2014 Ghassan Mohammed. All rights reserved.
//


import UIKit
import CoreLocation



class ViewController: UIViewController, CLLocationManagerDelegate {
    
    
    var pray = PrayTime()
    var dateComp : NSDateComponents = NSDateComponents()
    
    let locationManager = CLLocationManager()
    var geocoder = CLGeocoder()
    var placeMark : CLPlacemark?
    
    
    
    var currentTime = NSDate()
    var timer = NSTimer()
    
    var prayerArray : NSMutableArray = NSMutableArray()
    
    var calcMethodArray : [Int32] = [3,5,1,4,2]
    
    
    
   
    
    // get the current date
    var currentDate = CurrentDate()
    
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var fajrTime: UILabel!
    @IBOutlet weak var sunriseTime: UILabel!
    @IBOutlet weak var dhuhrTime: UILabel!
    @IBOutlet weak var asrTime: UILabel!
    @IBOutlet weak var maghribTime: UILabel!
    @IBOutlet weak var ishaTime: UILabel!
    
    @IBOutlet weak var currentTimeLabel: UILabel!
    
    
    @IBOutlet weak var cityStateLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        pray.setTimeFormat(0)
        updateUI()
        
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
            
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        updateUI()
        getCurrentTime()
        
        geocoder.reverseGeocodeLocation(locationManager.location, completionHandler: { (placeMarks, error) -> Void in
            if error == nil && placeMarks.count > 0 {
                //println(placeMarks[0])
                self.placeMark = placeMarks[0] as? CLPlacemark
                if let city = self.placeMark?.locality {
                    self.cityStateLabel.text = city
                }
            } else {
                println(error)
            }
            
        })
        
        self.locationLabel.text = "\(locationManager.location.coordinate.latitude)" + " \(locationManager.location.coordinate.longitude)"
    }
    
    override func viewDidAppear(animated: Bool) {
        
        updateUI()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func getCurrentTime() {
        
        timer.invalidate()
        currentTime = NSDate()
        var formatter = NSDateFormatter()
        formatter.timeStyle = NSDateFormatterStyle.MediumStyle
        currentTimeLabel.text = formatter.stringFromDate(currentTime)
        
         timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "getCurrentTime", userInfo: nil, repeats: true)
    }

        
        
        func prayerAlert (prayerName : String, prayHour : Int, prayMinute : Int) {
            var notification = UILocalNotification()
            notification.timeZone  = NSTimeZone.localTimeZone()
            notification.alertBody = prayerName
            notification.fireDate  = NSDate().fireDateAt(prayHour, min: prayMinute)
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        }
    
    
    
    func convertPrayArray (prayArray : NSMutableArray) ->(hourArray : [Int], minuteArray : [Int]) {
        
        var hours = [Int]()
        var minutes = [Int]()
        
        for var i = 0; i < prayArray.count; i++ {
            
            var rangeHours : NSRange = NSMakeRange(2, 3)
            var rangeMinutes : NSRange = NSMakeRange(0, 3)
            var hour = prayArray[i].stringByReplacingCharactersInRange(rangeHours, withString: "")
            hours.append(hour.toInt()!)
            var minute = prayArray[i].stringByReplacingCharactersInRange(rangeMinutes, withString: "")
            minutes.append(minute.toInt()!)
            
        }
        return (hours, minutes)
    }
    
    func convertTimeFormat (arrayOfTime : NSMutableArray) -> NSMutableArray {
        
        var convertedTimeArray = NSMutableArray()
        for var i = 0; i < arrayOfTime.count; i++ {
            
            var formatter = NSDateFormatter()
            formatter.dateFormat = "HH:mm"
            var time : NSDate = formatter.dateFromString(arrayOfTime[i] as NSString)!
            
            var secondFormatter = NSDateFormatter()
            secondFormatter.dateFormat = "hh:mm a"
            //secondFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
            
            var convertedTime = secondFormatter.stringFromDate(time)
            
            convertedTimeArray.addObject(convertedTime)
        }
        
        return convertedTimeArray
        
    }
    
    func updateUI () {
        
        var loadCalcInt = NSUserDefaults.standardUserDefaults()
        var calcInt = loadCalcInt.integerForKey("calcNumber")
        
        pray.setCalcMethod(Int32(calcMethodArray[calcInt]))
        
        prayerArray = pray.getDatePrayerTimes(currentDate.year, andMonth: currentDate.month, andDay: currentDate.day, andLatitude: locationManager.location.coordinate.latitude, andLongitude: locationManager.location.coordinate.longitude, andtimeZone: pray.timeZone)
        
        
        var convTime = convertTimeFormat(prayerArray)
        
        self.fajrTime.text = String(convTime[0] as NSString)
        self.sunriseTime.text = String(convTime[1] as NSString)
        self.dhuhrTime.text = String(convTime[2] as NSString)
        self.asrTime.text = String(convTime[3] as NSString)
        self.maghribTime.text = String(convTime[4] as NSString)
        self.ishaTime.text = String(convTime[6] as NSString)
        
        
        
        var timesArray = pray.getDatePrayerTimes(currentDate.year, andMonth: currentDate.month, andDay: currentDate.day, andLatitude: locationManager.location.coordinate.latitude, andLongitude: locationManager.location.coordinate.longitude, andtimeZone: pray.timeZone)
        
        
        var convertedTime = convertPrayArray(timesArray as NSMutableArray)
        
        prayerAlert("Time for Fajr", prayHour: convertedTime.hourArray[0], prayMinute: convertedTime.minuteArray[0])
        prayerAlert("Time for SunRise", prayHour: convertedTime.hourArray[1], prayMinute: convertedTime.minuteArray[1])
        prayerAlert("Time for Dhuhr", prayHour: convertedTime.hourArray[2], prayMinute: convertedTime.minuteArray[2])
        prayerAlert("Time for Asr", prayHour: convertedTime.hourArray[3], prayMinute: convertedTime.minuteArray[3])
        prayerAlert("Time for Maghrib", prayHour: convertedTime.hourArray[5], prayMinute: convertedTime.minuteArray[5])
        prayerAlert("Time for Isha", prayHour: convertedTime.hourArray[6], prayMinute: convertedTime.minuteArray[6])    }
    

}

