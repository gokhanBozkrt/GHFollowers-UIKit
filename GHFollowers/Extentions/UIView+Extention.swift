//
//  UIView+Extention.swift
//  GHFollowers
//
//  Created by Gokhan on 14.01.2024.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
