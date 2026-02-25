import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  // 카카오 로그인을 위한 URL 처리
  override func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey : Any] = [:]
  ) -> Bool {
    // Flutter 플러그인들이 URL을 처리할 수 있도록 먼저 전달
    if super.application(app, open: url, options: options) {
      return true
    }
    return false
  }
  
  // iOS 9 이상에서 사용되는 URL 처리 메서드
  override func application(
    _ application: UIApplication,
    open url: URL,
    sourceApplication: String?,
    annotation: Any
  ) -> Bool {
    // Flutter 플러그인들이 URL을 처리할 수 있도록 전달
    if super.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation) {
      return true
    }
    return false
  }
}
