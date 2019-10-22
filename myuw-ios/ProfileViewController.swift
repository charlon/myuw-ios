//
//  ProfileViewController.swift
//  myuw-test
//
//  Created by Charlon Palacay on 10/21/19.
//  Copyright © 2019 Charlon Palacay. All rights reserved.
//

import UIKit
import WebKit

class ProfileViewController: WebViewController {
    
    let url = URL(string: "https://my-test.s.uw.edu/profile/")!
    
    // override the viewDidLoad with "profile url"
    override func viewDidLoad() {
        view.backgroundColor = .brown
        
        webView.load(URLRequest(url: url))
    }
    
    override func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //webView.evaluateJavaScript("alert('hello');")
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
       //load cookie of current domain
        webView.loadDiskCookies(for: url.host!){
            decisionHandler(.allow)
        }
    }

    public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
       //write cookie for current domain
        webView.writeDiskCookies(for: url.host!){
            decisionHandler(.allow)
        }
    }
        
}
