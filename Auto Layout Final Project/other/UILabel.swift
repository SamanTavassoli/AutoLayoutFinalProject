//
//  UILabel.swift
//  Auto Layout Final Project
//
//  Created by Saman on 29/01/2020.
//  Copyright © 2020 theSamans. All rights reserved.
//

import Foundation
import UIKit

// copy pasta from stack overflow - https://stackoverflow.com/questions/27459746/adding-space-padding-to-a-uilabel
@IBDesignable class PaddingLabel: UILabel {

    @IBInspectable var topInset: CGFloat = 0.0
    @IBInspectable var bottomInset: CGFloat = 0.0
    @IBInspectable var leftInset: CGFloat = 6.0
    @IBInspectable var rightInset: CGFloat = 0.0

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}
//
