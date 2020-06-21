//
//  GFSecondaryTitleLabel.swift
//  GHFollowers
//
//  Created by Arrido Arfiadi on 3/29/20.
//  Copyright © 2020 Arrido Arfiadi. All rights reserved.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {

	  required init?(coder: NSCoder) {
		  fatalError("init(coder:) has not been implemented")
	  }
	  
	  convenience init(fontSize: CGFloat) {
		  self.init(frame: .zero)
		self.font = .systemFont(ofSize: fontSize, weight: .medium)
		
	  }
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	  
	  private func configure() {
		  textColor = .secondaryLabel
		  adjustsFontSizeToFitWidth = true
		  minimumScaleFactor = 0.9
		  lineBreakMode = .byTruncatingTail
		  textAlignment = .left
		  translatesAutoresizingMaskIntoConstraints = false
	  }

}
