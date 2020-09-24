//
//  UIView.swift
//  Auto Layout Final Project
//
//  Created by Saman on 29/01/2020.
//  Copyright © 2020 theSamans. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
     //copy pasta from stackoverflow - https://stackoverflow.com/questions/34868344/how-to-change-the-background-color-of-uistackview
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
    //
    
    func addBackground(color: UIColor, withBorderWidth: CGFloat) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.layer.borderWidth = 2.5
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}
