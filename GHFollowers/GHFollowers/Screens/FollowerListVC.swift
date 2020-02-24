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
	var page: Int = 1
	var hasMoreFollower = true
	var username: String!
	var collectionView: UICollectionView!
	var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
	var followers: [Follower] = []
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .systemBackground
		configureCollectionView()
		configureDataSource()
		getFollowers(username: username, page: page)
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
		collectionView.delegate = self
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
	
	private func getFollowers(username: String, page: Int) {
		showLoadingView()
		NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] (result) in
			guard let self = self else {return}
			self.dismissLoadingView()
			switch result {
			case .success(let followers):
				self.hasMoreFollower = followers.count == 100
				self.followers.append(contentsOf: followers)
				self.updateData()
			case .failure(let errorMessage):
				self.presentGFAlertOnMainThread(title: "Something went wrong", message: errorMessage.rawValue, buttonTitle: "Got it")
			}
		}
	}

}

extension FollowerListVC: UICollectionViewDelegate {
	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		let offsetY = scrollView.contentOffset.y
		let contentHeight = scrollView.contentSize.height
		let height = scrollView.frame.size.height
		
		if offsetY > contentHeight - height {
			guard hasMoreFollower else {return}
			page += 1
			getFollowers(username: username, page: page)
		}
		
	}
}
