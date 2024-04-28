//
//  GFItemFollowerVC.swift
//  GHFollowers
//
//  Created by Gökhan Bozkurt on 22.10.2023.
//

import UIKit

class GFItemFollowerVC: GFItemVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, with: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, with: user.following)
        actionButton.set(color: .systemGreen, title: "Get Followers", systemImageName: "person.3")
    }
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
