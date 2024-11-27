import UIKit
import WebKit
import Foundation

final class StartApeficonnectFlowViewController: UIViewController {
    
    private let viewModel: StartApeficonnectFlowViewModel = StartApeficonnectFlowViewModel()
    private var defaults = UserDefaults.standard
    private let progressView = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purpleCustom
        setupProgressView()
        setupRequest()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        progressView.startAnimating()
    }
    
    private func setupRequest() {
        
        viewModel.setupRequest { [weak self] result in
            guard let self else { return }
            self.progressView.stopAnimating()
            
            switch result {
            case .url(_):
                let link = URL(string:C.Call.privacyUrl)
                let request = URLRequest(url: link!)
                let config = WKWebViewConfiguration()
                config.userContentController = self.makeUserContentController()
                let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), configuration: config)
                self.view.addSubview(webView)
                webView.navigationDelegate = self
                webView.load(request)
            default:
                self.pushVC()
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
    
    func setupProgressView() {
        view.addSubview(progressView)
        progressView.color = .white
        progressView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
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
