//
//  AlertsDetailTableViewController.swift
//  PrayerTimes
//
//  Created by Ghassan Mohammed on 1/6/15.
//  Copyright (c) 2015 Ghassan Mohammed. All rights reserved.
//

import UIKit

class AlertsDetailTableViewController: UITableViewController {
    
    
    var alerts : Alert?

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if alerts?.name == "Fajr" {
//            loadSettings()
//        } else if alerts?.name == "Sunrise" {
//            loadSettings()
//        } else if alerts?.name == "Dhuhr" {
//            loadSettings()
//        } else if alerts?.name == "Asr" {
//            loadSettings()
//        } else if alerts?.name == "Maghrib" {
//            loadSettings()
//        } else if alerts?.name == "Isha" {
//            loadSettings()
//        }
        
        loadSettings()
    }
    

    
    override func viewDidDisappear(animated: Bool) {
        
//        if alerts?.name == "Fajr" {
//            saveSetting()
//        } else if alerts!.name == "Sunrise" {
//            saveSetting()
//        } else if alerts?.name == "Dhuhr" {
//            saveSetting()
//        } else if alerts?.name == "Asr" {
//            saveSetting()
//        } else if alerts?.name == "Maghrib" {
//            saveSetting()
//        } else if alerts?.name == "Isha" {
//            saveSetting()
//        }
        
        saveSetting()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        if alerts?.alertNames != nil {
            
            return alerts!.alertNames.count
        }
        return 0
    }

   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AlertsDetailCell", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        cell.textLabel?.text = alerts?.alertNames[indexPath.row]
        
                
        if alerts?.name == "Fajr" {
                if indexPath.row == alerts?.fajrAlertNumber {
                    
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                    cell.textLabel?.textColor = UIColor.redColor()
                } else {
                    cell.accessoryType = UITableViewCellAccessoryType.None
                    cell.textLabel?.textColor = UIColor.blackColor()
            }
        } else if alerts?.name == "Sunrise" {
            
                if indexPath.row == alerts?.sunriseAlertNumber {
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                } else {
                    cell.accessoryType = UITableViewCellAccessoryType.None
            }
        } else if alerts?.name == "Dhuhr"  {
            
                if indexPath.row == alerts?.dhuhrAlertNumber {
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                } else {
                    cell.accessoryType = UITableViewCellAccessoryType.None
            }
        } else if alerts?.name == "Asr" {
            
                if indexPath.row == alerts?.asralertNumber {
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                } else {
                    cell.accessoryType = UITableViewCellAccessoryType.None
            }
        } else if alerts?.name == "Maghrib" {
            
                if indexPath.row == alerts?.maghribAlertNumber {
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                } else {
                    cell.accessoryType = UITableViewCellAccessoryType.None
            }
        } else if alerts?.name == "Isha" {
                if indexPath.row == alerts?.ishaAlertNumber {
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                } else {
                    cell.accessoryType = UITableViewCellAccessoryType.None
            }
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if alerts?.name == "Fajr" {
                alerts?.fajrAlertNumber = indexPath.row
        } else if alerts?.name == "Sunrise" {
                alerts?.sunriseAlertNumber = indexPath.row
        }else if alerts?.name == "Dhuhr" {
                alerts?.dhuhrAlertNumber = indexPath.row
        }else if alerts?.name == "Asr" {
                alerts?.asralertNumber = indexPath.row
        }else if alerts?.name == "Maghrib" {
                alerts?.maghribAlertNumber = indexPath.row
        }else if alerts?.name == "Isha" {
                alerts?.ishaAlertNumber = indexPath.row
        }
        tableView.reloadData()
        
        
    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            
            if alerts?.name != nil {
            
            return String("\(alerts!.name)  PRAYER ALERT SETUP")
            }
        }
        return ""
    }
    
    func saveSetting () {
        
        
            
            var saveAlert = NSUserDefaults.standardUserDefaults()
            saveAlert.setObject(alerts?.fajrAlertNumber, forKey: "FajrAlert")
            saveAlert.setObject(alerts?.sunriseAlertNumber, forKey: "SunriseAlert")
            saveAlert.setObject(alerts?.dhuhrAlertNumber, forKey: "DhuhrAlert")
            saveAlert.setObject(alerts?.asralertNumber, forKey: "AsrAlert")
            saveAlert.setObject(alerts?.maghribAlertNumber, forKey: "MaghribAlert")
            saveAlert.setObject(alerts?.ishaAlertNumber, forKey: "IshaAlert")
            
            
            NSUserDefaults.standardUserDefaults().synchronize()
            
        
    }
    
    func loadSettings () {
        
        var loadAlertSettings = NSUserDefaults.standardUserDefaults()
        var fajrAlert = loadAlertSettings.objectForKey("FajrAlert") as? Int
        var sunriseAlert = loadAlertSettings.objectForKey("SunriseAlert") as? Int
        var dhuhrAlert = loadAlertSettings.objectForKey("DhuhrAlert") as? Int
        var asrAlert = loadAlertSettings.objectForKey("AsrAlert") as? Int
        var maghribAlert = loadAlertSettings.objectForKey("MaghribAlert") as? Int
        var ishaAlert = loadAlertSettings.objectForKey("IshaAlert") as? Int
        
        
        
        NSUserDefaults.standardUserDefaults().synchronize()
        
        alerts?.fajrAlertNumber = fajrAlert
        alerts?.sunriseAlertNumber = sunriseAlert
        alerts?.dhuhrAlertNumber = dhuhrAlert
        alerts?.asralertNumber = asrAlert
        alerts?.maghribAlertNumber = maghribAlert
        alerts?.ishaAlertNumber = ishaAlert
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
