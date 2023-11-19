//
//  Date+Extention.swift
//  GHFollowers
//
//  Created by Gökhan Bozkurt on 19.11.2023.
//

import Foundation

extension Date {
    func convertToString() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
