//
//  GFBodyLabel.swift
//  GHFollowers
//
//  Created by Arrido Arfiadi on 1/31/20.
//  Copyright © 2020 Arrido Arfiadi. All rights reserved.
//

import UIKit

class GFBodyLabel: UILabel {

   override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	init(textAlignment: NSTextAlignment) {
		super.init(frame: .zero)
		self.textAlignment = textAlignment
		configure()
	}
	
	private func configure() {
		font = UIFont.preferredFont(forTextStyle: .body)
		textColor = .secondaryLabel
		adjustsFontSizeToFitWidth = true
		minimumScaleFactor = 0.75
		lineBreakMode = .byWordWrapping
		translatesAutoresizingMaskIntoConstraints = false
	}

}
