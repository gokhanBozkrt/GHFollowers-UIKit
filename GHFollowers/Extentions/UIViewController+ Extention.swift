//
//  UIViewController+ Extention.swift
//  GHFollowers
//
//  Created by Gökhan Bozkurt on 29.06.2023.
//

import UIKit

extension UIViewController {
   
    func presentGFAlertOnMainThread(title: String,message: String,buttonTitle: String) {
        Task { @MainActor in
            let alertVC = GFAlertVC(alertTitle: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
