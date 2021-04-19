//
//  WebViewViewController.swift
//  HackerNews
//
//  Created by JurjDev on 15/04/21.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController, WKUIDelegate  {

    var url: URL!
    
    var webView: WKWebView!
}

// MARK: - Life Cycle

extension WebViewViewController {
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myRequest = URLRequest(url: url)
        webView.load(myRequest)
    }
}

extension WebViewViewController: InstantiableController {
    
    static func instance() -> Self {
        
        let vc = WebViewViewController()
        return vc as! Self
    }
}
