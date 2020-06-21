//
//  GFEmptyStateView.swift
//  GHFollowers
//
//  Created by Arrido Arfiadi on 2/29/20.
//  Copyright © 2020 Arrido Arfiadi. All rights reserved.
//

import UIKit

class GFEmptyStateView: UIView {
	private let messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
	private let logoImageView = UIImageView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureMessageLabel()
		configureLogoImageView()
	}
	
	convenience init(message: String) {
		self.init(frame: .zero)
		messageLabel.text = message
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configureLogoImageView() {
		addSubview(logoImageView)
		logoImageView.image = Images.emptyStateLogo
		logoImageView.translatesAutoresizingMaskIntoConstraints = false
		
		
		let logoBottomConstant: CGFloat = DeviceType.isiPhoneSE || DeviceType.isiPhone8Zoomed ? 100 : 40
		let logoImageViewBottomConstraint = logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: logoBottomConstant)
		
		NSLayoutConstraint.activate([
			logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
			logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
			logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
			logoImageViewBottomConstraint
		])
	}
	
	private func configureMessageLabel() {
		addSubview(messageLabel)
		messageLabel.numberOfLines = 3
		messageLabel.textColor = .secondaryLabel
		let messageLabelCenterYConstant: CGFloat = DeviceType.isiPhoneSE || DeviceType.isiPhone8Zoomed ? -90 : -150
		let messageLabelCenterYConstraint = messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: messageLabelCenterYConstant)
		NSLayoutConstraint.activate([
			messageLabelCenterYConstraint,
			messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
			messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
			messageLabel.heightAnchor.constraint(equalToConstant: 200)
		])
	}
	
	
}
