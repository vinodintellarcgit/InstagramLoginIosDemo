//
//  Extentions.swift
//  IntSocialFLogin
//
//  Created by Vinod Tiwari on 25/05/19.
//  Copyright © 2019 Intellarc. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func setCornerRadius(radius: CGFloat, borderwidth: CGFloat = 0, borderColor: UIColor? = nil) {
        self.layer.cornerRadius = radius
        self.layer.borderWidth = borderwidth
        self.layer.borderColor = borderColor?.cgColor
        self.layer.masksToBounds = true
    }
}

