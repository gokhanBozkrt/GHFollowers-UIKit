//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Gökhan Bozkurt on 27.08.2023.
//

import UIKit

class UserInfoVC: UIViewController {

    var userName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
       print(userName)
    }
    
  @objc func dismissVC() {
        dismiss(animated: true)
    }
    
}
