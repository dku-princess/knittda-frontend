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
           let bytes = args["bytes"] as? FlutterStandardTypedData,
           let image = UIImage(data: bytes.data) {

          // 사진첩에 저장
          UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
          result(true)

        } else {
          result(FlutterError(code: "INVALID_IMAGE", message: "이미지 변환 실패", details: nil))
        }

      case "shareImage":
        if let args = call.arguments as? [String: Any],
           let bytes = args["bytes"] as? FlutterStandardTypedData,
           let image = UIImage(data: bytes.data) {

          // 임시 경로에 저장
          let tempDir = FileManager.default.temporaryDirectory
          let fileURL = tempDir.appendingPathComponent("report.png")
          do {
            try image.pngData()?.write(to: fileURL)
          } catch {
            result(FlutterError(code: "FILE_WRITE_FAIL", message: "이미지 저장 실패", details: error.localizedDescription))
            return
          }

          // 공유 창 띄우기
          DispatchQueue.main.async {
            let activityVC = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
            controller.present(activityVC, animated: true, completion: nil)
            result(true)
          }

        } else {
          result(FlutterError(code: "INVALID_IMAGE", message: "이미지 바이트 없음 또는 변환 실패", details: nil))
        }

      default:
        result(FlutterMethodNotImplemented)
      }
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}