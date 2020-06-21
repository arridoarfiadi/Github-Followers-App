//
//  UIView+Ext.swift
//  GHFollowers
//
//  Created by Arrido Arfiadi on 6/21/20.
//  Copyright © 2020 Arrido Arfiadi. All rights reserved.
//

import UIKit

extension UIView {
	func pinToEdges(of superview: UIView) {
		translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			topAnchor.constraint(equalTo: superview.topAnchor),
			bottomAnchor.constraint(equalTo: superview.bottomAnchor),
			leadingAnchor.constraint(equalTo: superview.leadingAnchor),
			trailingAnchor.constraint(equalTo: superview.trailingAnchor),
		])
	}
	
	func addSubviews(_ views: UIView...){
		views.forEach({self.addSubview($0)})
	}
}
