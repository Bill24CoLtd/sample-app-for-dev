import UIKit
import Flutter
import bill24Sdk

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {

    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
      let channel = FlutterMethodChannel(name: "paymentSdk",binaryMessenger: controller.binaryMessenger)
      channel.setMethodCallHandler({
          [weak self] (call: FlutterMethodCall, results: @escaping (Any)->Void) -> Void in
          if(call.method == "paymentSdk") {
              let arguments = call.arguments as! [String: String]
              let sessionID : String? = arguments["session_id"]
              let language : String? = arguments["language"]
              let environment: String? = arguments["environment"]
              let clientID: String? = arguments["client_id"]
              let controller : FlutterViewController = self!.window?.rootViewController as! FlutterViewController
                    
                    self?.window.rootViewController?.dismiss(animated: true, completion: {
                        PaymentSdk().openSdk(controller: controller,sessionID: sessionID ?? "", cliendID: clientID ?? "",language: language ?? "",environment: environment ?? ""){result in
                      results(result)
                        
                  }
              })
          }
      })
      
      

      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
