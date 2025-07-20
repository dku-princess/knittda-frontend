import UIKit
import Flutter
import Photos

@main
@objc class AppDelegate: FlutterAppDelegate {
  private let channelName = "com.knittda/image_saver"

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    let controller = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: channelName, binaryMessenger: controller.binaryMessenger)

    channel.setMethodCallHandler { call, result in
      switch call.method {
      case "saveImage":
        if let args = call.arguments as? [String: Any],
           let bytes = args["bytes"] as? FlutterStandardTypedData {
          let image = UIImage(data: bytes.data)
          if let image = image {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            result(true)
          } else {
            result(FlutterError(code: "INVALID_IMAGE", message: "이미지 변환 실패", details: nil))
          }
        } else {
          result(FlutterError(code: "NO_BYTES", message: "이미지 데이터 없음", details: nil))
        }

      case "shareImage":
        if let args = call.arguments as? [String: Any],
           let path = args["path"] as? String {
          let url = URL(fileURLWithPath: path)
          let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
          controller.present(activityVC, animated: true, completion: nil)
          result(true)
        } else {
          result(FlutterError(code: "NO_PATH", message: "이미지 경로 없음", details: nil))
        }

      default:
        result(FlutterMethodNotImplemented)
      }
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
