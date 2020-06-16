//
//  GFItemInfoView.swift
//  GHFollowers
//
//  Created by Arrido Arfiadi on 6/14/20.
//  Copyright © 2020 Arrido Arfiadi. All rights reserved.
//

import UIKit

enum ItemInfoType {
	case repos,gists,followers,following
}

class GFItemInfoView: UIView {
	
	let symbolImageView = UIImageView()
	let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
	let countLabel = GFTitleLabel(textAlignment: .center, fontSize: 14)
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError()
	}
	
	private func configure() {
		addSubview(symbolImageView)
		addSubview(titleLabel)
		addSubview(countLabel)
		
		symbolImageView.translatesAutoresizingMaskIntoConstraints = false
		symbolImageView.contentMode = .scaleAspectFill
		
		NSLayoutConstraint.activate([
			symbolImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
			symbolImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
			symbolImageView.widthAnchor.constraint(equalToConstant: 20),
			symbolImageView.heightAnchor.constraint(equalTo: symbolImageView.widthAnchor, multiplier: 1.0),
			
			titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
			titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
			titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
			titleLabel.heightAnchor.constraint(equalToConstant: 18),
			
			countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 0),
			countLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
			countLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
			countLabel.heightAnchor.constraint(equalToConstant: 18)
		])
	}
	
	func set(itemInfoType: ItemInfoType, withCount count: Int) {
		countLabel.text = String(count)
		switch itemInfoType {
		case .repos:
			symbolImageView.image = UIImage(systemName: SFSymbols.repos)
			titleLabel.text = "Public Repos"
		case .gists:
			symbolImageView.image = UIImage(systemName: SFSymbols.gists)
			titleLabel.text = "Public Gists"
		case .followers:
			symbolImageView.image = UIImage(systemName: SFSymbols.follower)
			titleLabel.text = "Followers"
		case .following:
			symbolImageView.image = UIImage(systemName: SFSymbols.following)
			titleLabel.text = "Following"
		}
	}
}
