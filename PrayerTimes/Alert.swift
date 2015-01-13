//
//  Alert.swift
//  PrayerTimes
//
//  Created by Ghassan Mohammed on 1/6/15.
//  Copyright (c) 2015 Ghassan Mohammed. All rights reserved.
//

import UIKit

class Alert: NSObject {
    
    var name : String
    var alertNumber : Int?
    
    var alertNames : [String] = ["Vibrate Only", "No Alert", "Azhan", "Alarm Beep", "Short Beep"]
    
    init (name : String) {
        
        self.name = name
    }
    
    
}
