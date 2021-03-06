//
//  HomeViewController.swift
//  myuw-ios
//
//  Created by Charlon Palacay on 10/29/19.
//  Copyright © 2019 Charlon Palacay. All rights reserved.
//

import Foundation
import WebKit

class HomeViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!

    override func viewDidLoad() {
        view.backgroundColor = .brown
        let url = URL(string: "https://my-test.s.uw.edu/")!
        webView.load(URLRequest(url: url))
        
        self.title = "Home"
        
        // add a right button in navbar programatically
        let testUIBarButtonItem = UIBarButtonItem(title: "Profile", style: .plain, target: self, action: #selector(showProfile))
        self.navigationItem.rightBarButtonItem  = testUIBarButtonItem
        
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
            print("** home view **********")
            for cookie in cookies {
                print("name: \(cookie.name) value: \(cookie.value)")
            }
            
        }

        decisionHandler(.allow)
    }
    
    @objc func showProfile() {
        
        // instantiate instance of ProfileViewController
        let profileViewController = ProfileViewController()
                
        // set style of how view controller is to be presented
        if #available(iOS 13.0, *) {
            profileViewController.modalPresentationStyle = .automatic
        } else {
            // fallback on earlier versions
            profileViewController.modalPresentationStyle = .formSheet
        }
        
        // present the profile view controller
        present(profileViewController, animated: true, completion: nil)

    }
    
}
