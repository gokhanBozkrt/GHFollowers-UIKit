//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by Gökhan Bozkurt on 22.10.2023.
//

import UIKit

class GFRepoItemVC: GFItemVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, with: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, with: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
}
