#import "BarcodeReaderPlugin.h"
#if __has_include(<barcode_reader/barcode_reader-Swift.h>)
#import <barcode_reader/barcode_reader-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "barcode_reader-Swift.h"
#endif

@implementation BarcodeReaderPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBarcodeReaderPlugin registerWithRegistrar:registrar];
}
@end
