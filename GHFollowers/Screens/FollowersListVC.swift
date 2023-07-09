//
//  FollowersVC.swift
//  GHFollowers
//
//  Created by Gökhan Bozkurt on 28.06.2023.
//

import UIKit

class FollowersListVC: UIViewController {
    var userName: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
  
        
        NetworkManager.shared.getFollowers(for: userName ?? "", page: 1) { (result) in
            switch result {
            case .success(let followers):
                print("Followers.count = \(followers.count)")
                print(followers)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happend", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

