//
//  PrayMethodeNames.swift
//  PrayerTimes
//
//  Created by Ghassan Mohammed on 1/3/15.
//  Copyright (c) 2015 Ghassan Mohammed. All rights reserved.
//

import UIKit

class PrayMethodeNames: NSObject {
    
    
    
    var methodeName: String
    var methodeNumber : Int32
    var isChecked : Bool = false
    
    init (methodeName : String, methodeNumber : Int32) {
        
        self.methodeName = methodeName
        self.methodeNumber = methodeNumber
    }
    
    
    
   
}
