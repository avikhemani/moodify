//
//  MoodWebsiteViewController.swift
//  Moodify
//
//  Created by Avi Khemani on 5/28/19.
//  Copyright © 2019 Avi Khemani. All rights reserved.
//

import UIKit
import WebKit

class WebsiteViewController: UIViewController, WKNavigationDelegate {
 
    var urlString = "https://www.google.com" // default
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBAction func refreshPage(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    
    // Citation for WebView: https://www.youtube.com/watch?v=ZajIiG9kRR4
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        webView.navigationDelegate = self
        
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        spinner.stopAnimating()
    }
    
}



