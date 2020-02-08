#import "SystemNotificationsPlugin.h"
#if __has_include(<system_notifications/system_notifications-Swift.h>)
#import <system_notifications/system_notifications-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "system_notifications-Swift.h"
#endif

@implementation SystemNotificationsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSystemNotificationsPlugin registerWithRegistrar:registrar];
}
@end