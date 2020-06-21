//
//  FavouritesListVC.swift
//  GHFollowers
//
//  Created by Arrido Arfiadi on 1/31/20.
//  Copyright © 2020 Arrido Arfiadi. All rights reserved.
//

import UIKit

class FavouritesListVC: UIViewController {
	let tableView = UITableView()
	var favorites:[Follower] = []
    override func viewDidLoad() {
        super.viewDidLoad()
		configureViewController()
		configureTableView()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		getFavorites()
	}
	
	private func configureViewController() {
		view.backgroundColor = .systemBackground
		title = "Favorites"
		navigationController?.navigationBar.prefersLargeTitles = true
	}
	
	private func configureTableView() {
		view.addSubview(tableView)
		tableView.frame = view.bounds
		tableView.rowHeight = 80
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
	}
	
	private func getFavorites() {
		PersistenceManager.retrieveFavorites { [weak self] (result) in
			guard let self = self else {return}
			switch result {
			case .success(let favorites):
				self.set(favorites: favorites)
			case .failure(let error):
				self.presentGFAlertOnMainThread(title: "Something went wrong!", message: error.rawValue, buttonTitle: "Dismiss")
			}
		}
	}
	
	private func set(favorites: [Follower]) {
		if favorites.isEmpty {
			self.showEmptyStateView(with: "No Favorites\nAdd one on the follower screen", in: self.view)
		}
		self.favorites = favorites
		DispatchQueue.main.async {
			self.tableView.reloadData()
			self.view.bringSubviewToFront(self.tableView)
		}
	}
}


extension FavouritesListVC: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return favorites.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID, for: indexPath) as! FavoriteCell
		cell.set(favorite: favorites[indexPath.row])
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let favorite = favorites[indexPath.row]
		let destVC = FollowerListVC()
		destVC.username = favorite.login
		destVC.title = favorite.login
		navigationController?.pushViewController(destVC, animated: true)
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		guard editingStyle == .delete else {return}
		let favorite = favorites[indexPath.row]
		favorites.remove(at: indexPath.row)
		tableView.deleteRows(at: [indexPath], with: .left)
		PersistenceManager.update(with: favorite, actionType: .remove) { [weak self] (error) in
			guard let self = self else {return}
			guard let error = error else{return}
			self.presentGFAlertOnMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "Dismiss")
			
		}
	}

	
	
}
