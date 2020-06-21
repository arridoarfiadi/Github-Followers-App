//
//  UITableView+Ext.swift
//  GHFollowers
//
//  Created by Arrido Arfiadi on 6/21/20.
//  Copyright © 2020 Arrido Arfiadi. All rights reserved.
//

import UIKit

extension UITableView {
	func reloadDataOnMainThread() {
		DispatchQueue.main.async { [weak self] in
			self?.reloadData()
		}
	}
	
	func removeExcessCell() {
		tableFooterView = UIView()
	}
}
