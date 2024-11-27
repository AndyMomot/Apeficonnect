import UIKit
import WebKit
import Foundation

class StartApeficonnectFlowViewController: UIViewController {
    
    private let viewModel: StartApeficonnectFlowViewModel = StartApeficonnectFlowViewModel()
    
    private var defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRequest()
    }
    
    private func setupRequest() {
        
        viewModel.setupRequest { [self] result in
            switch result {
            case .url(_):
                let link = URL(string:C.Call.privacyUrl)
                let request = URLRequest(url: link!)
                let config = WKWebViewConfiguration()
                config.userContentController  = makeUserContentController()
                let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), configuration: config)
                view.addSubview(webView)
                webView.navigationDelegate = self
                webView.load(request)
            default:
                pushVC()
            }
        }
    }
    func pushVC() {
        let loadingViewController = RootViewController()
        loadingViewController.modalPresentationStyle = .overFullScreen
        loadingViewController.modalTransitionStyle = .crossDissolve
        
        self.present(loadingViewController, animated: true, completion: nil)
    }

    private func makeUserContentController() -> WKUserContentController {
        
        let userContentController = WKUserContentController()
        let script = """
        (function() {
            var originalLogFunction = console.log;
            console.log = function(message) {
                if (message == "click") {
                    window.webkit.messageHandlers.click.postMessage(message);
                }
                originalLogFunction.apply(console, arguments);
            };
        })();
        """
        let userScript = WKUserScript(source: script, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        userContentController.addUserScript(userScript)
        userContentController.add(self, name: "click")
        return userContentController
    }
    
}
@available(iOS 15, *)
extension StartApeficonnectFlowViewController: WKUIDelegate {
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        
        let configuration = WKWebViewConfiguration()
        return WKWebView(frame: webView.frame, configuration: configuration)
    }
}
@available(iOS 15, *)
extension StartApeficonnectFlowViewController: WKNavigationDelegate ,WKScriptMessageHandler{
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "click" {
            // EventService.shared.logSignUpEvent()
            CustomValidationManager.shared.signUpPressObserve()
        }
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print ("DID COMMIT")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print ("FINISHED LOADING")
        
    }
}
