//
//  GFAlertVC.swift
//  GHFollowers
//
//  Created by Arrido Arfiadi on 1/31/20.
//  Copyright © 2020 Arrido Arfiadi. All rights reserved.
//

import UIKit

class GFAlertVC: UIViewController {
	private let containerView = UIView()
	private let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
	private let messageLabel = GFBodyLabel(textAlignment: .center)
	private let actionButton = GFButton(backgroundColor: .systemPink, title: "Got it")
	private let PADDING: CGFloat = 20
	var alertTitle: String?
	var message: String?
	var buttonTitle: String?
	
	init(alertTitle: String, message: String, buttonTitle: String) {
		super.init(nibName: nil, bundle: nil)
		self.alertTitle = alertTitle
		self.message = message
		self.buttonTitle = buttonTitle
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
		configureContainerView()
		configureTitleLabel()
		configureActionButton()
		configureMessageLabel()
    }
	
	private func configureContainerView() {
		view.addSubview(containerView)
		containerView.layer.cornerRadius = 16
		containerView.layer.borderWidth = 2
		containerView.layer.borderColor = UIColor.white.cgColor
		containerView.backgroundColor = .systemBackground
		containerView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			containerView.heightAnchor.constraint(equalToConstant: 220),
			containerView.heightAnchor.constraint(equalToConstant: 280)
		])
	}
	
	private func configureTitleLabel() {
		containerView.addSubview(titleLabel)
		titleLabel.text = alertTitle ?? "Something went wrong"
		
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: PADDING),
			titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: PADDING),
			titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -PADDING),
			titleLabel.heightAnchor.constraint(equalToConstant: 28)
		])
	}
	
	
	private func configureActionButton() {
		containerView.addSubview(actionButton)
		actionButton.setTitle(buttonTitle ?? "Got it", for: .normal)
		actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
		
		NSLayoutConstraint.activate([
			actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -PADDING),
			actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: PADDING),
			actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -PADDING),
			actionButton.heightAnchor.constraint(equalToConstant: 50)
		])
	}
	
	private func configureMessageLabel() {
		containerView.addSubview(messageLabel)
		messageLabel.text = message ?? "Unable to complete request"
		messageLabel.numberOfLines = 0
		NSLayoutConstraint.activate([
			messageLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
			messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: PADDING),
			messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -PADDING),
			messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12),
		])
	}
	
	@objc private func dismissVC() {
		dismiss(animated: true, completion: nil)
	}


}
