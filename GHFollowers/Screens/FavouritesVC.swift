//
//  FavouritesVC.swift
//  GHFollowers
//
//  Created by Gökhan Bozkurt on 27.06.2023.
//

import UIKit

class FavouritesVC: UIViewController {
    
    let tableView = UITableView()
    var favourites = [Follower]()

    override func viewDidLoad() {
        super.viewDidLoad()
       configureViewController()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavourites()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Favourites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.removeExcessCells()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(FavouriteCell.self, forCellReuseIdentifier: FavouriteCell.reuseID)

    }

    func getFavourites() {
        PersistenceManager.retreiveFavourites { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let retrievedFavourites):
                if retrievedFavourites.isEmpty {
                    showEmptyStateView(with: "No Favourites", in: self.view)
                } else {
                    self.favourites = retrievedFavourites
                    Task { @MainActor in
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
               
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}

extension FavouritesVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favourites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteCell.reuseID) as! FavouriteCell
        let favouriteItem = favourites[indexPath.row]
        cell.set(favourite: favouriteItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favouriteItem = favourites[indexPath.row]
        let destVC = FollowersListVC(userName: favouriteItem.login)
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard  editingStyle == .delete else { return }
        PersistenceManager.updateWith(favourite: favourites[indexPath.row], actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                favourites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                return
            }
            self.presentGFAlertOnMainThread(title: "Error Happened", message: error.rawValue, buttonTitle: "Ok")
            
        }

    }
}
