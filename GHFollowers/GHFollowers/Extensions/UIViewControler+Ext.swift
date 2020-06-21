//
//  UIViewControler+Ext.swift
//  GHFollowers
//
//  Created by Arrido Arfiadi on 1/31/20.
//  Copyright © 2020 Arrido Arfiadi. All rights reserved.
//

import UIKit
import SafariServices



extension UIViewController {
	func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
		DispatchQueue.main.async { [weak self] in
			let alertVC = GFAlertVC(alertTitle: title, message: message, buttonTitle: buttonTitle)
			alertVC.modalPresentationStyle = .overFullScreen
			alertVC.modalTransitionStyle = .crossDissolve
			self?.present(alertVC, animated: true, completion: nil)
		}
	}
	

	
	func presentSafariVC(with url: URL) {
		let vc = SFSafariViewController(url: url)
		vc.preferredControlTintColor = .systemGreen
		present(vc, animated: true, completion: nil)
	}
}


