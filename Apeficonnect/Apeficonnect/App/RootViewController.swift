import SwiftUI
import WebKit

final class RootViewController: UIViewController {
    private let viewModel = StartApeficonnectFlowViewModel()
    private let swiftUIViewController = UIHostingController(rootView: RootContentView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSwiftUIView()
        setupRequest()
    }
}

private extension RootViewController {
    func showSwiftUIView() {
        // Добавляем новый контроллер как дочерний
        addChild(swiftUIViewController)
        view.addSubview(swiftUIViewController.view)
        swiftUIViewController.didMove(toParent: self)
        
        // Настраиваем ограничения для tabBarViewController
        swiftUIViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            swiftUIViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            swiftUIViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            swiftUIViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            swiftUIViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    func removeSwiftUIView() {
        swiftUIViewController.willMove(toParent: nil)
        swiftUIViewController.view.removeFromSuperview()
        swiftUIViewController.removeFromParent()
    }
}

private extension RootViewController {
    func setupRequest() {
        self.viewModel.setupRequest { [self] result in
            switch result {
            case .url:
                guard let link = URL(string:C.Call.privacyUrl) else { return }
                let request = URLRequest(url: link)
                let config = WKWebViewConfiguration()
                config.userContentController  = self.makeUserContentController()
                
                let webView = WKWebView(
                    frame: CGRect(
                        x: 0, y: 0,
                        width: self.view.frame.size.width,
                        height: self.view.frame.size.height),
                    configuration: config)
                webView.navigationDelegate = self
                
                DispatchQueue.main.async { [self] in
                    self.view.addSubview(webView)
                    webView.load(request)
                    
                    self.removeSwiftUIView()
                }
            default:
                break
            }
        }
    }
    
    func makeUserContentController() -> WKUserContentController {
        
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

extension RootViewController: WKUIDelegate {
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        
        let configuration = WKWebViewConfiguration()
        return WKWebView(frame: webView.frame, configuration: configuration)
    }
}

extension RootViewController: WKNavigationDelegate ,WKScriptMessageHandler{
    
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
