//
//  UITableView+Extension.swift
//  GHFollowers
//
//  Created by Gokhan on 9.03.2024.
//

import UIKit

extension UITableView {
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
