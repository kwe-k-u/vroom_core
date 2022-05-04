#import "VroomCorePlugin.h"
#if __has_include(<vroom_core/vroom_core-Swift.h>)
#import <vroom_core/vroom_core-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "vroom_core-Swift.h"
#endif

@implementation VroomCorePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftVroomCorePlugin registerWithRegistrar:registrar];
}
@end
