//
//  AppDelegate.swift
//  PrayerTimes
//
//  Created by Ghassan Mohammed on 12/23/14.
//  Copyright (c) 2014 Ghassan Mohammed. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // Actions
        var firstAction : UIMutableUserNotificationAction = UIMutableUserNotificationAction()
        firstAction.identifier = "FIRST_ACTION"
        firstAction.title = "First Action"
        
        firstAction.activationMode = UIUserNotificationActivationMode.Background
        firstAction.destructive = false
        firstAction.authenticationRequired = false
        
        var secondAction : UIMutableUserNotificationAction = UIMutableUserNotificationAction()
        secondAction.identifier = "SECOND_ACTION"
        secondAction.title = "Second Action"
        
        secondAction.activationMode = UIUserNotificationActivationMode.Background
        secondAction.destructive = false
        secondAction.authenticationRequired = false
        
        // Category
        var firstCategory : UIMutableUserNotificationCategory = UIMutableUserNotificationCategory()
        firstCategory.identifier = "FIRST_CATEGORY"
        let defaultAction : NSArray = [firstAction, secondAction]
        firstCategory.setActions(defaultAction, forContext: UIUserNotificationActionContext.Default)
        
        
        // NSSet for all categories
        let categories : NSSet = NSSet(object: firstCategory)
        
        
        
        
        
        let notificationTypes : UIUserNotificationType = UIUserNotificationType.Alert | UIUserNotificationType.Badge
        let notificationSetting : UIUserNotificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: categories)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSetting)
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

