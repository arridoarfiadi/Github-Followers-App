//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Arrido Arfiadi on 3/29/20.
//  Copyright © 2020 Arrido Arfiadi. All rights reserved.
//

import UIKit

protocol UserInfoVCDelegate: class {
	func didRequestFollowers(for username: String)
}

class UserInfoVC: GFDataLoadingVC {
	
	let scrollView = UIScrollView()
	let contentView = UIView()
	var username: String!
	let headerView = UIView()
	let itemViewOne = UIView()
	let itemViewTwo = UIView()
	var itemViews: [UIView] = []
	let dateLabel = GFBodyLabel(textAlignment: .center)
	weak var delegate: UserInfoVCDelegate?
	override func viewDidLoad() {
		super.viewDidLoad()
		configureScrollView()
		configureViewController()
		layoutUI()
		getUserInfo()
		
	}
	
	@objc private func dismissVC() {
		dismiss(animated: true, completion: nil)
	}
	
	private func getUserInfo() {
		NetworkManager.shared.getUserInfo(for: username) { [weak self] (result) in
			guard let self = self else {return}
			switch result {
			case .success(let user):
				DispatchQueue.main.async {
					self.configureUIElements(with: user)
				}
				
			case .failure(let error): self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
			}
		}
	}
	
	private func configureScrollView() {
		view.addSubview(scrollView)
		scrollView.addSubview(contentView)
		scrollView.pinToEdges(of: view)
		contentView.pinToEdges(of: scrollView)
		NSLayoutConstraint.activate([
			contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
			contentView.heightAnchor.constraint(equalToConstant: 800)
		])
	}
	
	private func configureUIElements(with user: User) {
		let repoItemVC = GFRepoItemVC(user: user)
		repoItemVC.delegate = self
		
		let followerItemVC = GFFollowerItemVC(user: user)
		followerItemVC.delegate = self
		
		
		self.add(chidVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
		self.add(chidVC: repoItemVC, to: self.itemViewOne)
		self.add(chidVC: followerItemVC, to: self.itemViewTwo)
		self.dateLabel.text = user.createdAt.convertToMonthYearFormat()
	}
	
	private func configureViewController() {
		view.backgroundColor = .systemBackground
		let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
		navigationItem.rightBarButtonItem = doneBarButton
	}
	
	private func layoutUI() {
		let padding: CGFloat = 20
		itemViews = [headerView, itemViewOne, itemViewTwo,dateLabel]
		itemViews.forEach({
			contentView.addSubview($0)
			$0.translatesAutoresizingMaskIntoConstraints = false
			$0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding).isActive = true
			$0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding).isActive = true
		})
		
		
		let itemHeight: CGFloat = 140
		NSLayoutConstraint.activate([
			headerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
			headerView.heightAnchor.constraint(equalToConstant: 210),
			
			itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
			itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
			
			itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
			itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
			
			dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
			dateLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 18)
			
		])
	}
	
	private func add(chidVC: UIViewController, to containerView: UIView) {
		addChild(chidVC)
		containerView.addSubview(chidVC.view)
		chidVC.view.frame = containerView.bounds
		chidVC.didMove(toParent: self)
	}
	
}

extension UserInfoVC: GFFollowerItemVCDelegate, GFRepoItemVCDelegate {
	func didTapGitHubProfile(for user: User) {
		guard let url = URL(string: user.htmlUrl) else {
			presentGFAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid", buttonTitle: "Dismiss")
			return
		}
		presentSafariVC(with: url)
		
	}
	
	func didTapGetFollowers(for user: User) {
		guard user.followers != 0 else {
			presentGFAlertOnMainThread(title: "No followers", message: "This user does not have any followers", buttonTitle: "Dismiss")
			return
		}
		delegate?.didRequestFollowers(for: user.login)
		dismissVC()
	}
}
