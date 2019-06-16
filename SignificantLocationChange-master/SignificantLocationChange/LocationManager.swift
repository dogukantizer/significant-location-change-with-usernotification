//
//  LocationManager.swift
//  SignificantLocationChange
//
//  Created by Doğukan Tizer on 15/6/19.
//

import UIKit
import CoreLocation
import UserNotifications

protocol LocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
}

class LocationManager: NSObject {
    
    var delegate: LocationManagerDelegate?
    
    lazy var alocationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
        manager.requestAlwaysAuthorization()
        manager.pausesLocationUpdatesAutomatically = false
        manager.allowsBackgroundLocationUpdates = true
        return manager
    }()
    
    override init() {
        super.init()
        alocationManager.startMonitoringSignificantLocationChanges()
        
        let notificationCenter = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                print("Kullanici notif bildirimine izin vermedi")
            }
        }
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        delegate?.locationManager(manager, didUpdateLocations: locations)
        for location in locations {
            print(location)
            scheduleNotification(notificationType: "Konum degisti", location:location)
        }
    }
    
    func scheduleNotification(notificationType: String, location: CLLocation) {
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        
        content.title = notificationType
        content.body = "Konum lat:" + String(location.coordinate.latitude)  + " long:" + String(location.coordinate.longitude)
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        let identifier = "Local Notification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: nil)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
    }
}
