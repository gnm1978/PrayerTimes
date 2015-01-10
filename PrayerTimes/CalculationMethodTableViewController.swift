//
//  CalculationMethodTableViewController.swift
//  PrayerTimes
//
//  Created by Ghassan Mohammed on 1/4/15.
//  Copyright (c) 2015 Ghassan Mohammed. All rights reserved.
//

import UIKit





class CalculationMethodTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var calcMethodNumber = UserSettings()
    var prayer = PrayTime()
    var prayerMethodeNames = [PrayMethodeNames]()
    var asrPrayerMethodNames = [PrayMethodeNames]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var prayMethod : PrayMethodeNames = PrayMethodeNames(methodeName: "Muslim World League", methodeNumber: 3)
        prayerMethodeNames.append(prayMethod)
        prayMethod = PrayMethodeNames(methodeName: "Egyptian General Authority", methodeNumber: 5)
        prayerMethodeNames.append(prayMethod)
        prayMethod = PrayMethodeNames(methodeName: "Islamic University, Katachi", methodeNumber: 1)
        prayerMethodeNames.append(prayMethod)
        prayMethod = PrayMethodeNames(methodeName: "Umm Al-Qura", methodeNumber: 4)
        prayerMethodeNames.append(prayMethod)
        prayMethod = PrayMethodeNames(methodeName: "ISNA (North America)", methodeNumber: 2)
        prayerMethodeNames.append(prayMethod)
        
        var asrPrayerMethod : PrayMethodeNames = PrayMethodeNames(methodeName: "Auto: Shafi", methodeNumber: 0)
        asrPrayerMethodNames.append(asrPrayerMethod)
        asrPrayerMethod = PrayMethodeNames(methodeName: "Standard(Shafi, Maliki, Hanbali)", methodeNumber: 0)
        asrPrayerMethodNames.append(asrPrayerMethod)
        asrPrayerMethod = PrayMethodeNames(methodeName: "Hanafi", methodeNumber: 1)
        asrPrayerMethodNames.append(asrPrayerMethod)
        
        
        loadSettings()
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        
        saveSettings()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 2
    }


    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return prayerMethodeNames.count
        } else if section == 1 {
            return asrPrayerMethodNames.count
        }
        return 0
        
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        
        cell.textLabel?.text = prayerMethodeNames[indexPath.row].methodeName
        
        if indexPath.row == calcMethodNumber.calcMethodChecked {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            prayerMethodeNames[indexPath.row].isChecked = true
            prayer.setCalcMethod(prayerMethodeNames[indexPath.row].methodeNumber)
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.None
            prayerMethodeNames[indexPath.row].isChecked = false
        }
        
        return cell
        } else if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
            cell.textLabel?.text = asrPrayerMethodNames[indexPath.row].methodeName
            
           
            
            if indexPath.row == calcMethodNumber.asrMethodChecked {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                asrPrayerMethodNames[indexPath.row].isChecked = true
                prayer.setAsrMethod(asrPrayerMethodNames[indexPath.row].methodeNumber)
            }else {
                cell.accessoryType = UITableViewCellAccessoryType.None
                asrPrayerMethodNames[indexPath.row].isChecked = false
            }
            
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 0 {
        calcMethodNumber.calcMethodChecked = indexPath.row
        tableView.reloadData()
        } else if indexPath.section == 1 {
            calcMethodNumber.asrMethodChecked = indexPath.row
            tableView.reloadData()
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 70.00
        } else if section == 1 {
            return 70.00
        }
        return CGFloat()
        
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "Prayer Method"
        } else if section == 1 {
            return "Asr Prayer Method"
        }
        return ""
    }
    
    func saveSettings () {
        
        if calcMethodNumber.calcMethodChecked != nil {
            var saveCalcInt = NSUserDefaults.standardUserDefaults()
            saveCalcInt.setInteger(calcMethodNumber.calcMethodChecked!, forKey: "calcNumber")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        if calcMethodNumber.asrMethodChecked != nil {
            var saveAsrInt = NSUserDefaults.standardUserDefaults()
            saveAsrInt.setInteger(calcMethodNumber.asrMethodChecked!, forKey: "asrCalcNumber")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    func loadSettings () {
        
        var loadCalcInt = NSUserDefaults.standardUserDefaults()
        var calcInt = loadCalcInt.integerForKey("calcNumber")
        
        var loadAsrInt = NSUserDefaults.standardUserDefaults()
        var asrInt = loadAsrInt.integerForKey("asrCalcNumber")
        
        NSUserDefaults.standardUserDefaults().synchronize()
        
        calcMethodNumber.calcMethodChecked = calcInt
        calcMethodNumber.asrMethodChecked = asrInt
    }
    
    
    
}
