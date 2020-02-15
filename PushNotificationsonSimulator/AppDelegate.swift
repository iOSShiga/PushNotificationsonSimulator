//
//  AppDelegate.swift
//  PushNotificationsonSimulator
//
//  Created by shiga on 16/02/20.
//  Copyright © 2020 shiga. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        configureNotification()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}



extension AppDelegate {
    
    func configureNotification()  {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .badge, .alert]) { (grant, error) in
            print(grant)
            UNUserNotificationCenter.current().delegate = self
            
            self.setNotificationCategories()
            
        }
    }
    
    
    func setNotificationCategories()  {
        
        let openHomePage = UNNotificationAction(identifier: UNNotificationDefaultActionIdentifier, title: "Open Home Page", options: UNNotificationActionOptions.foreground)
        
        let contentAddedCategory = UNNotificationCategory(identifier: "CustomSimplePush", actions: [openHomePage], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: "", options: UNNotificationCategoryOptions.customDismissAction)
        
        UNUserNotificationCenter.current().setNotificationCategories([contentAddedCategory])
        
        
    }
    
}


extension AppDelegate: UNUserNotificationCenterDelegate  {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.sound, .alert, .badge])
    }
}
