//
//  UserInputManager.swift
//  links
//
//  Created by Saman on 29/03/2020.
//  Copyright © 2020 Samans. All rights reserved.
//

import Foundation
import UIKit

class UserInputManager {
    
    class func recordUserInput(_ textField: UITextField,_ websitePosition: Int) {
        let userInput = textField.text ?? "" // if no text then set to ""
        let url = URL(string: userInput)
        let collectionVC = UIApplication.shared.windows.first!.rootViewController as! CollectionViewController // finding VC to change websiteList data
        collectionVC.websiteList.setWebsite(url, websitePosition)
        
    }
    
    class func handleTouch(_ vc: PopUpViewController,_ view: UIView,_ touches: Set<UITouch>) {
        if let touch = touches.first?.location(in: view) {
            if vc.webViewActive { // if webview - look for close button touch, then remove both button & webkit subviews and show main view
                let frame = view.subviews[2].frame
                if (frame.minX < touch.x && frame.maxX > touch.x
                && frame.minY < touch.y && frame.maxY > touch.y) {
                    view.subviews[2].removeFromSuperview()
                    view.subviews[1].removeFromSuperview()
                    view.subviews[0].isHidden = false
                    vc.webViewActive = false
                }
            } else { // if main view - tap outside of view goes back, tap inside opens website unless clicked on textField
                let frame = view.subviews[0].frame
                if !(frame.minX < touch.x && frame.maxX > touch.x
                    && frame.minY < touch.y && frame.maxY > touch.y) {
                    vc.webViewActive = false
                    vc.removeAndAnimateOut()
                } else { // if touching inside, open website
                    let collectionVC = UIApplication.shared.windows.first!.rootViewController as! CollectionViewController // getting reference to website data to find the url we are looking for
                    if let website = collectionVC.websiteList.getWebsite(vc.websitePosition) {
                        WebKitHandler.openWebsite(website, view, vc.webView)
                        vc.webViewActive = true
                    }
                }
            }
        }
    }
    
}
