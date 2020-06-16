//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by Arrido Arfiadi on 6/14/20.
//  Copyright © 2020 Arrido Arfiadi. All rights reserved.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureItem()
	}
	
	private func configureItem() {
		itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
		itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
		actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
		
	}
	
	override func actionButtonTapped() {
		super.actionButtonTapped()
		delegate.didTapGitHubProfile(for: user)
	}
}

