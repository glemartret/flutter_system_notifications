import Flutter
import UIKit

public class SwiftSystemNotificationsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "system_notifications", binaryMessenger: registrar.messenger())
    let instance = SwiftSystemNotificationsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    let center = UNUserNotificationCenter.current()
    center.requestAuthorization(options: [.alert, .sound]) { granted, error in
        // Enable or disable features based on authorization.
    }
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let arguments = call.arguments as? [AnyHashable: Any] else { return }
    switch call.method {
    case "makeNotification":
        makeNotification(id: arguments["id"] as! Int, title: arguments["title"] as! String, content: arguments["content"] as! String)
    default:
        result(FlutterMethodNotImplemented);
    }
  }

    public func makeNotification(id: Int, title: String, content: String) {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized else { return }
            let notificationContent = UNMutableNotificationContent()
            notificationContent.title = title
            notificationContent.body = content
            var dateComponents = DateComponents()
            dateComponents.calendar = Calendar.current
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            let uuidString = UUID().uuidString
            let request = UNNotificationRequest(identifier: uuidString,
                        content: notificationContent, trigger: trigger)
            let notificationCenter = UNUserNotificationCenter.current()
            notificationCenter.add(request) { (error) in
               if error != nil {
                    print(error!)
               }
            }
            // if settings.alertSetting == .enabled {
            //     // Schedule an alert-only notification.
            // } else {
            //     // Schedule a notification with a badge and sound.
            // }
        }
    }
}
