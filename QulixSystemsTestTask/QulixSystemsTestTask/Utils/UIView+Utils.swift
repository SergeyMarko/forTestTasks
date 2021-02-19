//
//  UIView+Utils.swift
//  QulixSystemsTestTask
//
//  Created by 1 on 2/19/21.
//

import UIKit

extension UIView {
    
    func roundCorners(with radius: Int) {
        layer.cornerRadius = bounds.width / CGFloat(radius)
        clipsToBounds = true
    }
}
