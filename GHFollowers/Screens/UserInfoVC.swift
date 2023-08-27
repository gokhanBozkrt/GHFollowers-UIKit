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
      
        NetworkManager.shared.getUserInfo(for: userName) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                print(user)
            case .failure(let failure):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: failure.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
  @objc func dismissVC() {
        dismiss(animated: true)
    }
    

    
}
