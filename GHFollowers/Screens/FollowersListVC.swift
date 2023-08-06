//
//  FollowersVC.swift
//  GHFollowers
//
//  Created by Gökhan Bozkurt on 28.06.2023.
//

import UIKit

class FollowersListVC: UIViewController {
    
    enum Section {
        case main
    }
    
    var userName: String?
    var followers = [Follower]()
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section,Follower>!
    var page = 1
    var hasMoreFollowers = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers(userName: userName ?? "", page: page)
        configureDataSource()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
  
    
    func getFollowers(userName: String, page: Int) {
               showLoadingView()
               NetworkManager.shared.getFollowers(for: userName, page: page) { [weak self] (result) in
                   guard let self = self else { return }
                   self.dismissLoadingView()
                   switch result {
                   case .success(let followers):
                       if followers.count < 100 {  self.hasMoreFollowers = false }
                       print("Followers.count = \(followers.count)")
                       self.followers.append(contentsOf: followers)
                       self.updateData()
                   case .failure(let error):
                       self.presentGFAlertOnMainThread(title: "Bad Stuff Happend", message: error.rawValue, buttonTitle: "Ok")
                   }
               }
        }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    func updateData() {
        var snapChat = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapChat.appendSections([.main])
        snapChat.appendItems(followers)
        Task { @MainActor in
            self.dataSource.apply(snapChat, animatingDifferences: true)
        }
    }
    
}



extension FollowersListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // Y coordinate in scrollview
        let offsetY = scrollView.contentOffset.y
        // Height of scrollview
        let contentHeight = scrollView.contentSize.height
        // height of your screen
        let height = scrollView.frame.size.height
        
        
//        print("offsetY: \(offsetY)")
//        print("contentHeight: \(contentHeight)")
//        print("height: \(height)")
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(userName: userName ?? "", page: page)
        }
    }
}
