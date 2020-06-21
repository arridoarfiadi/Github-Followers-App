//
//  UIView+Ext.swift
//  GHFollowers
//
//  Created by Arrido Arfiadi on 6/21/20.
//  Copyright © 2020 Arrido Arfiadi. All rights reserved.
//

import UIKit

extension UIView {
	func addSubviews(_ views: UIView...){
		views.forEach({self.addSubview($0)})
	}
}
