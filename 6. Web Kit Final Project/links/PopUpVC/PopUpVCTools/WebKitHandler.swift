//
//  WebkitHandler.swift
//  links
//
//  Created by Saman on 29/03/2020.
//  Copyright © 2020 Samans. All rights reserved.
//

import Foundation
import WebKit

class WebKitHandler {
    class func openWebsite(_ url: URL,_ view: UIView,_ webView: WKWebView) {
        
        // webview
        view.addSubview(webView)
        webView.frame = CGRect(x: view.frame.minX + 20, y: view.frame.minY + 40, width: view.frame.width - 40, height: view.frame.height - 200)
        webView.layer.cornerRadius = 8
        
        // close button view
        let closeWebBrowserButtonSubview = Bundle.main.loadNibNamed("closeWebBrowserButton", owner: view, options: nil)![0] as! UIView
        view.addSubview(closeWebBrowserButtonSubview)
        closeWebBrowserButtonSubview.frame = CGRect(x:  webView.frame.minX, y: webView.frame.maxY + 20, width: webView.frame.width, height: 100)
        closeWebBrowserButtonSubview.layer.cornerRadius = 8
        
        // main view
        view.subviews[0].isHidden = true // hide the previous subview now that the webview is in use
        
        view.layoutSubviews()
        if let url = URL(string: "https://\(url)") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
