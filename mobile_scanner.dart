Readme
Changelog
Example
Installing
Versions
Scores
mobile_scanner 
pub package style: lint mobile_scanner GitHub Sponsors

A universal scanner for Flutter based on MLKit. Uses CameraX on Android and AVFoundation on iOS.

Breaking Changes v5.0.0 
Version 5.0.0 brings some breaking changes. However, some are reverted in version 5.1.0. Please see the list below for all breaking changes, and Changelog.md for a more detailed list.

The autoStart attribute has been removed from the MobileScannerController. The controller should be manually started on-demand. (Reverted in version 5.1.0)
A controller is now required for the MobileScanner widget. (Reverted in version 5.1.0)
The onDetect method has been removed from the MobileScanner widget. Instead, listen to MobileScannerController.barcodes directly. (Reverted in version 5.1.0)
The width and height of BarcodeCapture have been removed, in favor of size.
The raw attribute is now Object? instead of dynamic, so that it participates in type promotion.
The MobileScannerArguments class has been removed from the public API, as it is an internal type.
The cameraFacingOverride named argument for the start() method has been renamed to cameraDirection.
The analyzeImage function now correctly returns a BarcodeCapture? instead of a boolean.
The formats attribute of the MobileScannerController is now non-null.
The MobileScannerState enum has been renamed to MobileScannerAuthorizationState.
The various ValueNotifiers for the camera state have been removed. Use the value of the MobileScannerController instead.
The hasTorch getter has been removed. Instead, use the torch state of the controller's value.
The TorchState enum now provides a new value for unavailable flashlights.
The onPermissionSet, onStart and onScannerStarted methods have been removed from the MobileScanner widget. Instead, await MobileScannerController.start().
The startDelay has been removed from the MobileScanner widget. Instead, use a delay between manual starts of one or more controllers.
The overlay widget of the MobileScanner has been replaced by a new property, overlayBuilder, which provides the constraints for the overlay.
The torch can no longer be toggled on the web, as this is only available for image tracks and not video tracks. As a result the torch state for the web will always be TorchState.unavailable.
The zoom scale can no longer be modified on the web, as this is only available for image tracks and not video tracks. As a result, the zoom scale will always be 1.0.
Features Supported 
See the example app for detailed implementation information.

Features	Android	iOS	macOS	Web
analyzeImage (Gallery)	✔️	✔️	✔️	❌
returnImage	✔️	✔️	✔️	❌
scanWindow	✔️	✔️	✔️	❌
Platform Support 
Android	iOS	macOS	Web	Linux	Windows
✔	✔	✔	✔	❌	❌
Platform specific setup 
Android 
This package uses by default the bundled version of MLKit Barcode-scanning for Android. This version is immediately available to the device. But it will increase the size of the app by approximately 3 to 10 MB.

The alternative is to use the unbundled version of MLKit Barcode-scanning for Android. This version is downloaded on first use via Google Play Services. It increases the app size by around 600KB.

You can read more about the difference between the two versions here.

To use the unbundled version of the MLKit Barcode-scanning, add the following line to your /android/gradle.properties file:

dev.steenbakker.mobile_scanner.useUnbundled=true
iOS 
Add the following keys to your Info.plist file, located in NSCameraUsageDescription - describe why your app needs access to the camera. This is called Privacy - Camera Usage Description in the visual editor.

If you want to use the local gallery feature from image_picker NSPhotoLibraryUsageDescription - describe why your app needs permission for the photo library. This is called Privacy - Photo Library Usage Description in the visual editor.

Example,

<key>NSCameraUsageDescription</key>
<string>This app needs camera access to scan QR codes</string>

<key>NSPhotoLibraryUsageDescription</key>
<string>This app needs photos access to get QR code from photo library</string>
macOS 
Ensure that you granted camera permission in XCode -> Signing & Capabilities:

Screenshot of XCode where Camera is checked
Web 
As of version 5.0.0 adding the barcode scanning library script to the index.html is no longer required, as the script is automatically loaded on first use.

Providing a mirror for the barcode scanning library 
If a different mirror is needed to load the barcode scanning library, the source URL can be set beforehand.

import 'package:flutter/foundation.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

final String scriptUrl = // ...

if (kIsWeb) {
  MobileScannerPlatform.instance.setBarcodeLibraryScriptUrl(scriptUrl);
}
Usage 
Import the package with package:mobile_scanner/mobile_scanner.dart.

Create a new MobileScannerController controller, using the required options. Provide a StreamSubscription for the barcode events.

final MobileScannerController controller = MobileScannerController(
  // required options for the scanner
);

StreamSubscription<Object?>? _subscription;
Ensure that your State class mixes in WidgetsBindingObserver, to handle lifecyle changes:

class MyState extends State<MyStatefulWidget> with WidgetsBindingObserver {
  // ...

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // If the controller is not ready, do not try to start or stop it.
    // Permission dialogs can trigger lifecycle changes before the controller is ready.
    if (!controller.value.hasCameraPermission) {
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        // Restart the scanner when the app is resumed.
        // Don't forget to resume listening to the barcode events.
        _subscription = controller.barcodes.listen(_handleBarcode);

        unawaited(controller.start());
      case AppLifecycleState.inactive:
        // Stop the scanner when the app is paused.
        // Also stop the barcode events subscription.
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(controller.stop());
    }
  }

  // ...
