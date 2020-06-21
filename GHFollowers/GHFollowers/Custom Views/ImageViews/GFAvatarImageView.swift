//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Arrido Arfiadi on 2/3/20.
//  Copyright © 2020 Arrido Arfiadi. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {
	private let cache = NetworkManager.shared.cache
	private let placeholderImage = Images.placeholder
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configure() {
		layer.cornerRadius = 10
		clipsToBounds = true
		image = placeholderImage
		translatesAutoresizingMaskIntoConstraints = false
	}
	
	func setImage(from urlString: String) {
		NetworkManager.shared.downloadImage(from: urlString) { [weak self] (image) in
			if let image = image {
				DispatchQueue.main.async {
					self?.image = image
				}
			}
		}
	}

}
