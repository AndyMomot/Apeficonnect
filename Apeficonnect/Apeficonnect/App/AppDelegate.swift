
import UIKit
import CoreData
import FirebaseCore
import OneSignalFramework
import FBSDKCoreKit
import AdSupport
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let test2 = isAppAlreadyLaunchedOnce()
        print(test2)
        
        FirebaseApp.configure()
        FirebaseManagerCustom.shared.requestRemoteConfiguration()

        OneSignal.Debug.setLogLevel(.LL_VERBOSE)
        OneSignal.initialize("dc31ed06-af02-4566-9809-c3e5fac65c6c", withLaunchOptions: launchOptions)
        
        OneSignal.Notifications.requestPermission({ accepted in
            print("User accepted notifications: \(accepted)")
        }, fallbackToSettings: false)
        return true
    }
    
    func isAppAlreadyLaunchedOnce()->Bool{
        
        var _mindgrow = "_Link_mindgrowoln"
        for i in _mindgrow {
            if i == "d" {
                _mindgrow += "d_mindgrowf"
            } else {
                _mindgrow += "s_mindgrow2"
            }
        }
        let defaults = UserDefaults.standard
        
        if defaults.bool(forKey: "isAppAlreadyLaunchedOnce"){
            let bool = defaults.bool(forKey: "isAppAlreadyLaunchedOnce")
            print("App already launched : \(bool)")
            return true
        }else{
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            print("App launched first time")
            // Override point for customization after application launch.
            let userDefaults = UserDefaults.standard
            var faviriteData = [NSMutableDictionary]()
            
            faviriteData.append(["data":0,"isSelect":"YES","value":"PLN"])
            faviriteData.append(["data":1,"isSelect":"YES","value":"EUR"])
            faviriteData.append(["data":2,"isSelect":"YES","value":"USD"])
            faviriteData.append(["data":3,"isSelect":"YES","value":"GBP"])
            userDefaults.set(faviriteData, forKey: "favorite")
            userDefaults.synchronize()
            
            
            return false
        }
    }
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
            // Called when a new scene session is being created.
            // Use this method to select a configuration to create the new scene with.
            let config = UISceneConfiguration(name: "My Scene Delegate", sessionRole: connectingSceneSession.role)
            config.delegateClass = SceneDelegate.self
            print("SceneDelegate accessed")
            return config
        }

    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
    }
}
