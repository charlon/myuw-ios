//
//  ProfileViewController.swift
//  myuw-test
//
//  Created by Charlon Palacay on 10/21/19.
//  Copyright © 2019 Charlon Palacay. All rights reserved.
//

import UIKit
import WebKit

class ProfileViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!

    override func viewDidLoad() {
        view.backgroundColor = .brown
        let url = URL(string: "https://my-test.s.uw.edu/profile/")!
        webView.load(URLRequest(url: url))
        
        self.title = "Profile"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func loadView() {
        let configuration = WKWebViewConfiguration()
        
        configuration.websiteDataStore = WKWebsiteDataStore.default()
        configuration.processPool = WKProcessPool()
        webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        webView.navigationDelegate = self
        self.view = webView
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    
    // get the cookies
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        webView.configuration.websiteDataStore.httpCookieStore.getAllCookies { cookies in
            
            //debugPrint(cookies.debugDescription)
            print("**********")
            for cookie in cookies {
                print("name: \(cookie.name) value: \(cookie.value)")
            }
            
        }

        decisionHandler(.allow)
    }
    
}
