import UIKit
import WebKit

enum Result {
    case url(URL?)
    case error
    case native
}

final class StartApeficonnectFlowViewModel: NSObject {
    
    private var customCheckerManagering = CustomCheckerManagering()
    
    func navigateToOnboard(vc: UIViewController) {
        //
        let onboardVC = RootViewController()
        //
        vc.present(onboardVC, animated: true, completion: nil)
    }
    
    func setupRequest(_ handler: @escaping (Result) -> Void) {
        guard let requestedUrl = URL(string: C.Call.privacyUrl) else {
            handler(.error)
            return
        }
        customCheckerManagering.checkRedirect(url: requestedUrl) { redirected, urlToRedirect, error in
            if error != nil {
                handler(.error)
            } else {
                print(redirected)
                guard redirected, let urlRedirected = urlToRedirect else {
                    handler(.native)
                    return
                }
                handler(.url(urlRedirected))
            }
        }
    }
}
