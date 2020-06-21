//
//  GFFollowerItemVC.swift
//  GHFollowers
//
//  Created by Arrido Arfiadi on 6/14/20.
//  Copyright © 2020 Arrido Arfiadi. All rights reserved.
//

import UIKit

protocol GFFollowerItemVCDelegate: class {
	func didTapGetFollowers(for user: User)
}

class GFFollowerItemVC: GFItemInfoVC {
	weak var delegate: GFFollowerItemVCDelegate?
	override func viewDidLoad() {
		super.viewDidLoad()
		configureItem()
	}
	
	
	private func configureItem() {
		itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
		itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
		actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
	}
	
	override func actionButtonTapped() {
		super.actionButtonTapped()
		delegate?.didTapGetFollowers(for: user)
	}
	
}

