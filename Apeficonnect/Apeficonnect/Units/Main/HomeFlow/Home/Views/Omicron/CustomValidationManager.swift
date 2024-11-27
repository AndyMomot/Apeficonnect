import Foundation
import FBSDKCoreKit
import FirebaseAnalytics

final class CustomValidationManager {

    static let shared = CustomValidationManager()
    private var defaults = UserDefaults.standard

    private init() { }

    func signUpPressObserve() {
        let status = defaults.bool(forKey: "status")
        if status {
            Analytics.logEvent(AnalyticsEventSignUp, parameters: [
                AnalyticsParameterMethod: "email" as NSObject
            ])
            AppEvents.logEvent(.completedRegistration)
        }
    }
}
