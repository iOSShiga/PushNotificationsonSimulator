//
//  NotificationViewController.swift
//  content
//
//  Created by shiga on 16/02/20.
//  Copyright © 2020 shiga. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet var label: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        self.label?.text = notification.request.content.body
        self.imageView.contentMode = .scaleToFill
        
        displayImage(using: notification)
    }
    
     // Mark:- get Image url from notification
        
        func displayImage(using notification: UNNotification)  {
                    let content = notification.request.content
            
                    if let urlImageString = content.userInfo["urlImageString"] as? String {
                        if let url = URL(string: urlImageString) {
                            URLSession.downloadImage(atURL: url) { [weak self] (data, error) in
                                if let _ = error {
                                    return
                                }
                                guard let data = data else {
                                    return
                                }
                                DispatchQueue.main.async {
                                    self?.imageView.image = UIImage(data: data)
                                }
                            }
                        }
                    }
        }

}


// Mark:- download Image from url

extension URLSession {
    
    class func downloadImage(atURL url: URL, withCompletionHandler completionHandler: @escaping (Data?, NSError?) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            completionHandler(data, nil)
        }
        dataTask.resume()
    }
    
}
