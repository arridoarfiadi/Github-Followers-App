//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Arrido Arfiadi on 1/31/20.
//  Copyright © 2020 Arrido Arfiadi. All rights reserved.
//

import UIKit

class FollowerListVC: UIViewController {
	enum Section {
		case main
	}
	var username: String!
	var collectionView: UICollectionView!
	var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
	var followers: [Follower] = []
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .systemBackground
		configureCollectionView()
		configureDataSource()
		getFollowers()
    }
    
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationController?.setNavigationBarHidden(false, animated: true)
	}
	
	
	
	private func configureCollectionView() {
		collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
		view.addSubview(collectionView)
		collectionView.backgroundColor = .systemBackground
		collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
	}
	
	private func configureDataSource() {
		dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
			cell.set(follower: follower)
			return cell
		})
	}
	
	private func updateData() {
		var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
		snapshot.appendSections([.main])
		snapshot.appendItems(followers)
		DispatchQueue.main.async { [weak self] in
			guard let self = self else {return}
			self.dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
		}
		
	}
	
	private func getFollowers() {
		NetworkManager.shared.getFollowers(for: username, page: 1) { [weak self] (result) in
			guard let self = self else {return}
			switch result {
			case .success(let followers):
				self.followers = followers
				self.updateData()
			case .failure(let errorMessage):
				self.presentGFAlertOnMainThread(title: "Something went wrong", message: errorMessage.rawValue, buttonTitle: "Got it")
			}
		}
	}

}
