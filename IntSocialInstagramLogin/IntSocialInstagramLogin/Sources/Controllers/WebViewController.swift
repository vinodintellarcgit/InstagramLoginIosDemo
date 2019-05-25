//
//  WebViewController.swift
//  IntSocialInstagramLogin
//
//  Created by Vinod Tiwari on 22/05/19.
//  Copyright © 2019 Intellarc. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.loadWebview()
    }
    
    private func loadWebview() {
        
        webView.navigationDelegate = self
        let authURL = String(format: "%@?client_id=%@&redirect_uri=%@&response_type=token&scope=%@&DEBUG=True", arguments: [API.INSTAGRAM_AUTHURL,API.INSTAGRAM_CLIENT_ID,API.INSTAGRAM_REDIRECT_URI, API.INSTAGRAM_SCOPE])
        print(authURL)
        let urlRequest = URLRequest.init(url: URL.init(string: authURL)!)
        webView.load(urlRequest)
    }

    private func checkRequestForCallbackURL(request: URLRequest) {
        let requestURLString = (request.url?.absoluteString)! as String
        if requestURLString.hasPrefix(API.INSTAGRAM_REDIRECT_URI) {
            let range: Range<String.Index> = requestURLString.range(of: "#access_token=")!
            handleAuth(authToken: requestURLString.substring(from: range.upperBound))
        }
    }
    private func handleAuth(authToken: String) {
        webView.navigationDelegate = nil
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        vc.setAccesToken(token: authToken)
        API.INSTAGRAM_ACCESS_TOKEN_AUTH = authToken
        self.navigationController?.pushViewController(vc, animated: true)
        print("Instagram authentication token ==", authToken)
    }
}

extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        let url = webView.url
        print(url?.absoluteString as Any)
        print("Strat to load")
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish to load")
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let request = navigationAction.request.url
        print("decidePolicyFor ::::\(String(describing: request?.absoluteString))")
        checkRequestForCallbackURL(request: navigationAction.request)
        decisionHandler(.allow)
    }
}
