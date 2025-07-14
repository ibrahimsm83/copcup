import Flutter
import UIKit
import GoogleMaps // ✅ Add this import

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

   // ✅ Initialize Google Maps SDK with your API key
          GMSServices.provideAPIKey("AIzaSyABvYZeEXmiChqjPm7FPi9s9dxojDHGAek")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

//AIzaSyABvYZeEXmiChqjPm7FPi9s9dxojDHGAek