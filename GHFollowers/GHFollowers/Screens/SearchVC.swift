//
//  SearchVC.swift
//  GHFollowers
//
//  Created by Arrido Arfiadi on 1/31/20.
//  Copyright © 2020 Arrido Arfiadi. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

	private let logoImageView = UIImageView()
	private let usernameTextField = GFTextField()
	private let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get followers")
	var logoImageViewTopConstraint: NSLayoutConstraint!
	
	var isUsernameEntered: Bool {
		return !usernameTextField.text!.isEmpty
	}
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .systemBackground
		configureLogoImageView()
		configureTextField()
		configureCallToActionButton()
		dismissKeyboardTapGesture()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		usernameTextField.text = ""
		navigationController?.isNavigationBarHidden = true
	}
	
	private func dismissKeyboardTapGesture() {
		let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
		view.addGestureRecognizer(tap)
	}
	
	@objc private func pushFollowerListVC() {
		guard isUsernameEntered else {
			presentGFAlertOnMainThread(title: "Empty Username", message: "Please enter a username", buttonTitle: "Got it")
			return
		}
		usernameTextField.resignFirstResponder()
		let followerListVC = FollowerListVC(username: usernameTextField.text!)
		navigationController?.pushViewController(followerListVC, animated: true)
	}
	
	private func configureLogoImageView() {
		view.addSubview(logoImageView)
		logoImageView.translatesAutoresizingMaskIntoConstraints = false
		logoImageView.image = Images.ghLogo
		let topConstraintConstant: CGFloat = DeviceType.isiPhoneSE || DeviceType.isiPhone8Zoomed ? 20 : 80
		logoImageViewTopConstraint = logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant)
		NSLayoutConstraint.activate([
			logoImageViewTopConstraint,
			logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			logoImageView.heightAnchor.constraint(equalToConstant: 200),
			logoImageView.widthAnchor.constraint(equalToConstant: 200)
		
		])
	}

	private func configureTextField() {
		view.addSubview(usernameTextField)
		usernameTextField.delegate = self
		NSLayoutConstraint.activate([
			usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
			usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
			usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
			usernameTextField.heightAnchor.constraint(equalToConstant: 50)
		
		])
	}
	
	private func configureCallToActionButton() {
		callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
		view.addSubview(callToActionButton)
		NSLayoutConstraint.activate([
			callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
			callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
			callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
			callToActionButton.heightAnchor.constraint(equalToConstant: 50)
		])
	}
	
	

}

extension SearchVC: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		pushFollowerListVC()
		return true
	}
}
