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
        
        loadSettings()
    }
    override func viewDidDisappear(animated: Bool) {
        
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
                if indexPath.row == alerts?.alertNumber {
                    
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                    cell.textLabel?.textColor = UIColor.redColor()
                } else {
                    cell.accessoryType = UITableViewCellAccessoryType.None
                    cell.textLabel?.textColor = UIColor.blackColor()
            }
        } else if alerts?.name == "Sunrise" {
            
                if indexPath.row == alerts?.alertNumber {
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                    cell.textLabel?.textColor = UIColor.redColor()
                } else {
                    cell.accessoryType = UITableViewCellAccessoryType.None
                    cell.textLabel?.textColor = UIColor.blackColor()
            }
        } else if alerts?.name == "Dhuhr"  {
            
                if indexPath.row == alerts?.alertNumber {
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                    cell.textLabel?.textColor = UIColor.redColor()
                } else {
                    cell.accessoryType = UITableViewCellAccessoryType.None
                    cell.textLabel?.textColor = UIColor.blackColor()
            }
        } else if alerts?.name == "Asr" {
            
                if indexPath.row == alerts?.alertNumber {
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                    cell.textLabel?.textColor = UIColor.redColor()
                } else {
                    cell.accessoryType = UITableViewCellAccessoryType.None
                    cell.textLabel?.textColor = UIColor.blackColor()
            }
        } else if alerts?.name == "Maghrib" {
            
                if indexPath.row == alerts?.alertNumber {
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                    cell.textLabel?.textColor = UIColor.redColor()
                } else {
                    cell.accessoryType = UITableViewCellAccessoryType.None
                    cell.textLabel?.textColor = UIColor.blackColor()
            }
        } else if alerts?.name == "Isha" {
                if indexPath.row == alerts?.alertNumber {
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                    cell.textLabel?.textColor = UIColor.redColor()
                } else {
                    cell.accessoryType = UITableViewCellAccessoryType.None
                    cell.textLabel?.textColor = UIColor.blackColor()
            }
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if alerts?.name == "Fajr" {
                alerts?.alertNumber = indexPath.row
        } else if alerts?.name == "Sunrise" {
                alerts?.alertNumber = indexPath.row
        }else if alerts?.name == "Dhuhr" {
                alerts?.alertNumber = indexPath.row
        }else if alerts?.name == "Asr" {
                alerts?.alertNumber = indexPath.row
        }else if alerts?.name == "Maghrib" {
                alerts?.alertNumber = indexPath.row
        }else if alerts?.name == "Isha" {
                alerts?.alertNumber = indexPath.row
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
        
        if alerts?.name == "Fajr" {
            saveAlert.setObject(alerts?.alertNumber, forKey: "FajrAlert")
            
        } else if alerts?.name == "Sunrise" {
            saveAlert.setObject(alerts?.alertNumber, forKey: "SunriseAlert")
            
        } else if alerts?.name == "Dhuhr" {
            saveAlert.setObject(alerts?.alertNumber, forKey: "DhuhrAlert")
            
        } else if alerts?.name == "Asr" {
            saveAlert.setObject(alerts?.alertNumber, forKey: "AsrAlert")
            
        } else if alerts?.name == "Maghrib" {
            saveAlert.setObject(alerts?.alertNumber, forKey: "MaghribAlert")
            
        } else if alerts?.name == "Isha" {
            saveAlert.setObject(alerts?.alertNumber, forKey: "IshaAlert")
            
        }
        
            NSUserDefaults.standardUserDefaults().synchronize()
            
        
    }
    
    func loadSettings () {
        
        
        
        var loadAlertSettings = NSUserDefaults.standardUserDefaults()
        
        if alerts?.name == "Fajr" {
            var fajrAlert = loadAlertSettings.objectForKey("FajrAlert") as? Int
            alerts?.alertNumber = fajrAlert
            
            println("loaded")
        } else if alerts?.name == "Sunrise" {
            var sunriseAlert = loadAlertSettings.objectForKey("SunriseAlert") as? Int
            alerts?.alertNumber = sunriseAlert
            
        } else if alerts?.name == "Dhuhr" {
            var dhuhrAlert = loadAlertSettings.objectForKey("DhuhrAlert") as? Int
            alerts?.alertNumber = dhuhrAlert
            
        } else if alerts?.name == "Asr" {
            var asrAlert = loadAlertSettings.objectForKey("AsrAlert") as? Int
            alerts?.alertNumber = asrAlert
            
        } else if alerts?.name == "Maghrib" {
            var maghribAlert = loadAlertSettings.objectForKey("MaghribAlert") as? Int
            alerts?.alertNumber = maghribAlert
            
        } else if alerts?.name == "Isha" {
            var ishaAlert = loadAlertSettings.objectForKey("IshaAlert") as? Int
            alerts?.alertNumber = ishaAlert
            
        }
        
        NSUserDefaults.standardUserDefaults().synchronize()
        

        
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
