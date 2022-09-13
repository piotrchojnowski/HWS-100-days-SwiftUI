//
//  LocalNotificationsExampleView.swift
//  Project16
//
//  Created by Piotr Chojnowski on 13/09/2022.
//

import SwiftUI
import UserNotifications

struct LocalNotificationsExampleView: View {
    var body: some View {
        VStack {
            Button("Request Permission") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("all good")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }

            Button("Schedule Notification") {
                let content = UNMutableNotificationContent()
                content.title = "Make some apps"
                content.subtitle = "do not procrastinate 😂"
                content.sound = UNNotificationSound.default
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                let request = UNNotificationRequest(identifier: UUID().uuidString,
                                                    content: content,
                                                    trigger: trigger)
                
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
}

struct LocalNotificationsExampleView_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationsExampleView()
    }
}
