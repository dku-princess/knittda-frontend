import Flutter
import UIKit
import Photos
@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    let controller = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: "com.knittda/image_saver", binaryMessenger: controller.binaryMessenger)

    channel.setMethodCallHandler { call, result in
      if call.method == "saveImage",
         let args = call.arguments as? [String: Any],
         let bytes = args["bytes"] as? FlutterStandardTypedData {

        let image = UIImage(data: bytes.data)
        if let image = image {
          UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
          result(true)
        } else {
          result(FlutterError(code: "INVALID_IMAGE", message: "이미지 변환 실패", details: nil))
        }
      }
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
