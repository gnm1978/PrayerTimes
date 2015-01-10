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
    let locationManager = CLLocationManager()
    var geocoder = CLGeocoder()
    var placeMark : CLPlacemark?
    
    
    
    var currentTime = NSDate()
    var timer = NSTimer()
    
    var prayerArray = []
   
    
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
        
        
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
            
        }
        var date = NSDate(timeIntervalSince1970: 1)
       
        pray.setTimeFormat(1)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        getCurrentTime()
        
        
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
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var locValue:CLLocationCoordinate2D = manager.location.coordinate
        //println("locations = \(locValue.latitude) \(locValue.longitude)")
        self.locationLabel.text = "\(locValue.latitude)" + " \(locValue.longitude)"
        
        var prayerArray = pray.getDatePrayerTimes(currentDate.year, andMonth: currentDate.month, andDay: currentDate.day, andLatitude: locValue.latitude, andLongitude: locValue.longitude, andtimeZone: pray.timeZone)
        
        self.fajrTime.text = String(prayerArray[0] as NSString)
        self.sunriseTime.text = String(prayerArray[1] as NSString)
        self.dhuhrTime.text = String(prayerArray[2] as NSString)
        self.asrTime.text = String(prayerArray[3] as NSString)
        self.maghribTime.text = String(prayerArray[4] as NSString)
        self.ishaTime.text = String(prayerArray[6] as NSString)
        
        geocoder.reverseGeocodeLocation(manager.location, completionHandler: { (placeMarks, error) -> Void in
            
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
        
        //println(prayerArray)
    }
    
    func prayerAlert () {
        
            var alert = UIAlertController(title: "Pray", message: "Its Time to Pray", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        
        
    }
    
    @IBAction func testbutton(sender: AnyObject) {
        
        var alert = UIAlertController(title: "test", message: "this is a test alert", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
    
    
}

