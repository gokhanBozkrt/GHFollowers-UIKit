//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Gökhan Bozkurt on 27.08.2023.
//

import UIKit

class UserInfoVC: UIViewController {

    var userName: String!
    let headerView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        layoutUI()
        NetworkManager.shared.getUserInfo(for: userName) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                DispatchQueue.main.async {  
                    self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
                }
            case .failure(let failure):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: failure.rawValue, buttonTitle: "Ok")
            }
        }
        
        
    }
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.frame
        childVC.didMove(toParent: self)
    }
    
    func layoutUI() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180)
        ])
        
        
    }
  @objc func dismissVC() {
        dismiss(animated: true)
    }
    

    
}
