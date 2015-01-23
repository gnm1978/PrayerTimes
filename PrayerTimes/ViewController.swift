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
    
    
    //var pray = PrayTime()
    var dateComp : NSDateComponents = NSDateComponents()
    let locationManager = CLLocationManager()
    var geocoder = CLGeocoder()
    var placeMark : CLPlacemark?
    var calcMethodNumber : Int32?
    var prayTime = PrayTimesSechedul()
    var currentTime = NSDate()
    var timer = NSTimer()
    var prayMethod = UserSettings()
    var currentDate = CurrentDate()
    var notification : UILocalNotification?
    
    
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
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
        }
        
        
       
        
        var calcMethod = NSUserDefaults.standardUserDefaults().integerForKey("MethodNumber")
        var asrMethod = NSUserDefaults.standardUserDefaults().integerForKey("AsrMethodNumber")

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "calcMethod:", name: "calcMethodData", object: nil)
        
    
    }
    

    
    override func viewWillAppear(animated: Bool) {
        
        
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

        
        
    
    
    func alerts () {
        
            var notificationFajr : UILocalNotification = UILocalNotification()
            notificationFajr.timeZone = NSTimeZone.defaultTimeZone()
            notificationFajr.alertBody = "Time For Fajr Prayer"
        if prayTime.fajr.compare(currentTime) == NSComparisonResult.OrderedDescending {
            notificationFajr.fireDate = prayTime.fajr
            UIApplication.sharedApplication().scheduleLocalNotification(notificationFajr)
        }
        
        
            var notificationSunrise : UILocalNotification = UILocalNotification()
            notificationSunrise.timeZone = NSTimeZone.defaultTimeZone()
            notificationSunrise.alertBody = "Time For Sunrise Prayer"
        if prayTime.sunrise.compare(currentTime) == NSComparisonResult.OrderedDescending {
            notificationSunrise.fireDate = prayTime.sunrise
            UIApplication.sharedApplication().scheduleLocalNotification(notificationSunrise)
        }
        
            var notificationDhuhr : UILocalNotification = UILocalNotification()
            notificationDhuhr.timeZone = NSTimeZone.defaultTimeZone()
            notificationDhuhr.alertBody = "Time For Dhuhr Prayer"
        if prayTime.dhuhr.compare(currentTime) == NSComparisonResult.OrderedDescending {
            notificationDhuhr.fireDate = prayTime.dhuhr
            UIApplication.sharedApplication().scheduleLocalNotification(notificationDhuhr)
        }
        
        
            var notificationAsr : UILocalNotification = UILocalNotification()
            notificationAsr.timeZone = NSTimeZone.defaultTimeZone()
            notificationAsr.alertBody = "Time For Asr Prayer"
        if prayTime.asr.compare(currentTime) == NSComparisonResult.OrderedDescending {
            notificationAsr.fireDate = prayTime.asr
            UIApplication.sharedApplication().scheduleLocalNotification(notificationAsr)
        }
        
            var notificationMaghrib : UILocalNotification = UILocalNotification()
            notificationMaghrib.timeZone = NSTimeZone.defaultTimeZone()
            notificationMaghrib.alertBody = "Time For Maghrib Prayer"
        if prayTime.maghrib.compare(currentTime) == NSComparisonResult.OrderedDescending {
            notificationMaghrib.fireDate = prayTime.maghrib
            UIApplication.sharedApplication().scheduleLocalNotification(notificationMaghrib)
        }
        
        
        
            var notificationIsha : UILocalNotification = UILocalNotification()
            notificationIsha.timeZone = NSTimeZone.defaultTimeZone()
            notificationIsha.alertBody = "Time For Isha Prayer"
        if prayTime.isha.compare(currentTime) == NSComparisonResult.OrderedDescending {
            notificationIsha.fireDate = prayTime.isha
            UIApplication.sharedApplication().scheduleLocalNotification(notificationIsha)
        }
        
        var notificationTest : UILocalNotification = UILocalNotification()
        notificationTest.timeZone = NSTimeZone.defaultTimeZone()
        var fireDate = NSDate().fireDateAt(19, min: 48)
        notificationTest.alertBody = "This is a test"
        if fireDate.compare(currentTime) == NSComparisonResult.OrderedDescending {
            
            notificationTest.fireDate = fireDate
            UIApplication.sharedApplication().scheduleLocalNotification(notificationTest)
        }
        
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        var convTime = convertTimeFormat(prayTime.prayArray)
        
        self.fajrTime.text = String(convTime[0] as NSString)
        self.sunriseTime.text = String(convTime[1] as NSString)
        self.dhuhrTime.text = String(convTime[2] as NSString)
        self.asrTime.text = String(convTime[3] as NSString)
        self.maghribTime.text = String(convTime[4] as NSString)
        self.ishaTime.text = String(convTime[6] as NSString)
        
        self.locationLabel.text = "\(locationManager.location.coordinate.latitude)" + " \(locationManager.location.coordinate.longitude)"
        alerts()
        
    }
    
    
    func convertTimeFormat (arrayOfTime : NSMutableArray) -> NSMutableArray {
        
        var convertedTimeArray = NSMutableArray()
        for var i = 0; i < arrayOfTime.count; i++ {
            
            var formatter = NSDateFormatter()
            formatter.dateFormat = "HH:mm"
            var time : NSDate = formatter.dateFromString(arrayOfTime[i] as NSString)!
            
            var secondFormatter = NSDateFormatter()
            secondFormatter.dateFormat = "hh:mm a"

            
            var convertedTime = secondFormatter.stringFromDate(time)
            
            convertedTimeArray.addObject(convertedTime)
        }
        
        return convertedTimeArray
        
    }
    
    }

