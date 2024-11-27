import UIKit
import FirebaseRemoteConfig
import FBSDKCoreKit

final class FirebaseManagerCustom {
    
    var appId = ""
    var clientToken = ""
    var displayName = ""
    
    private var remoteConfiguration = RemoteConfig.remoteConfig()
    
    static let shared = FirebaseManagerCustom()
    
    private init() { }
    
    private func initializeFBSDK() {
        Settings.appID       = self.appId
        Settings.displayName = self.displayName
        Settings.isAdvertiserIDCollectionEnabled = true
        Settings.clientToken = self.clientToken
        Settings.isAutoLogAppEventsEnabled = true
        Settings.initialize()
    }
    
    func requestRemoteConfiguration() {
        let defaults: [String: NSObject] = [
            "appId" : "" as NSObject,
            "clientToken" : "" as NSObject,
            "displayName" : "" as NSObject
        ]

        let setting = RemoteConfigSettings()
        setting.minimumFetchInterval = 10
        remoteConfiguration.configSettings = setting
        remoteConfiguration.setDefaults(defaults)
        remoteConfiguration.fetchAndActivate {[weak self] status, error in
            guard let self else { return }
            if error != nil {
                print("Error Remote Config: ", error!.localizedDescription)
            } else {
                if status != .error || status == .successFetchedFromRemote || status == .successUsingPreFetchedData {
                    if let appId = self.remoteConfiguration.configValue(forKey: "appId").stringValue {
                        self.appId = appId
                    }

                    if let clientToken = self.remoteConfiguration.configValue(forKey: "clientToken").stringValue {
                        self.clientToken = clientToken
                    }
                    
                    if let displayName = self.remoteConfiguration.configValue(forKey: "displayName").stringValue {
                        self.displayName = displayName
                        print(displayName)
                    }

                    ApplicationDelegate.shared.application(
                        UIApplication.shared,
                        didFinishLaunchingWithOptions: nil
                    )

                    self.initializeFBSDK()
                }
            }
        }
    }
}
