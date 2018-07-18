//
//  NotificationHandler.swift
//  SmartBag
//
//  Created by Janna Herrmann on 05.07.18.
//  Copyright © 2018 Deutsches Forschungszentrum fuer Kuenstliche Intelligenz GmbH. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationHandler {
    
    static var repeatAfterSeconds = 60
    static var repeats = false
    
    static func pushOutOfRangeNotification(){
       
        let notification = UNMutableNotificationContent()
        notification.title = "Out Of Range!"
        notification.body = "The SmartBag is not in your range anymore."
        
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(NotificationHandler.repeatAfterSeconds), repeats: NotificationHandler.repeats)
        let request = UNNotificationRequest(identifier: "outOfRange", content: notification, trigger: notificationTrigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
    
     static func pushOpeningNotification(){
        
        let notification = UNMutableNotificationContent()
        notification.title = "Opening!"
        notification.body = "Someone opened your SmartBag."
        
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(NotificationHandler.repeatAfterSeconds), repeats: NotificationHandler.repeats)
        let request = UNNotificationRequest(identifier: "opening", content: notification, trigger: notificationTrigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
    
}
