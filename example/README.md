# system_notifications_example

Demonstrates how to use the system_notifications plugin.

# iOS Setup

If you want System notification while the app is in foreground add this:

In your AppDelegate.swift add this function:
```
override func userNotificationCenter(_ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.alert, .badge, .sound])
}
```

And add in your application function:
```
UNUserNotificationCenter.current().delegate = self
```