//
//  PopUpViewController.swift
//  links
//
//  Created by Saman on 28/03/2020.
//  Copyright © 2020 Samans. All rights reserved.
//

import UIKit
import WebKit

class PopUpViewController: UIViewController {
    
    @IBOutlet var textField: UITextField!
    
    var websitePosition = 0
    var webView = WKWebView()
    var webViewActive = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    }
    
    
    // MARK: User Interaction
    
    @IBAction func textFieldEdittingDidEnd(_ sender: Any) {
        UserInputManager.recordUserInput(textField, websitePosition)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UserInputManager.recordUserInput(textField, websitePosition)
        UserInputManager.handleTouch(self, view, touches)
    }
    
    // record user input, remove view and animate out
    func removeAndAnimateOut() {
        UserInputManager.recordUserInput(textField, websitePosition)
        
        self.view.backgroundColor = UIColor.clear
        UIView.animate(
            withDuration: 0.4,
            delay: 0.0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 0.4,
            animations: {
                self.view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                self.view.alpha = 0.0
        }, completion: { _ in
            self.view.removeFromSuperview()
        })
    }
}
