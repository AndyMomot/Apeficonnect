import Foundation

class CustomCheckerManagering: NSObject, URLSessionTaskDelegate {
    var hasRedirected: Bool = false
    var redirectURL: URL?

    func checkRedirect(url: URL, completion: @escaping (Bool, URL?, Error?) -> Void) {
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration, delegate: self, delegateQueue: nil)
        
        var request = URLRequest(url: url)
        request.httpMethod = "HEAD"
        
        let task = session.dataTask(with: request) { _, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(false, nil, error)
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    print(statusCode)
                    if (300...399).contains(statusCode) {
                        self.hasRedirected = true
                    } else {
                        
                    }
                }
                completion(self.hasRedirected, self.redirectURL, nil)
            }
        }
        task.resume()
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        hasRedirected = true
        redirectURL = request.url
        completionHandler(nil)
    }
}
