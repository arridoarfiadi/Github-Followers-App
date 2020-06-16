//
//  UIViewControler+Ext.swift
//  GHFollowers
//
//  Created by Arrido Arfiadi on 1/31/20.
//  Copyright © 2020 Arrido Arfiadi. All rights reserved.
//

import UIKit
import SafariServices

fileprivate var containerView: UIView!

extension UIViewController {
	func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
		DispatchQueue.main.async { [weak self] in
			let alertVC = GFAlertVC(alertTitle: title, message: message, buttonTitle: buttonTitle)
			alertVC.modalPresentationStyle = .overFullScreen
			alertVC.modalTransitionStyle = .crossDissolve
			self?.present(alertVC, animated: true, completion: nil)
		}
	}
	
	func showLoadingView() {
		containerView = UIView(frame: view.bounds)
		view.addSubview(containerView)
		containerView.backgroundColor = .systemBackground
		
		containerView.alpha = 0
		
		UIView.animate(withDuration: 0.25) {
			containerView.alpha = 0.5
		}
		
		let activityIndicator = UIActivityIndicatorView(style: .large)
		containerView.addSubview(activityIndicator)
		
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
			activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
		])
		
		activityIndicator.startAnimating()
	}
	
	func dismissLoadingView() {
		DispatchQueue.main.async {
			containerView.removeFromSuperview()
			containerView = nil
		}
		
	}
	
	func showEmptyStateView(with message: String, in view: UIView) {
		let emptyStateView = GFEmptyStateView(message: message)
		emptyStateView.frame = view.bounds
		view.addSubview(emptyStateView)
	}
	
	func presentSafariVC(with url: URL) {
		let vc = SFSafariViewController(url: url)
		vc.preferredControlTintColor = .systemGreen
		present(vc, animated: true, completion: nil)
	}
}


