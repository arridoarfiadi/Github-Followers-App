//
//  Date-Ext.swift
//  GHFollowers
//
//  Created by Arrido Arfiadi on 6/14/20.
//  Copyright © 2020 Arrido Arfiadi. All rights reserved.
//

import Foundation



extension Date {
	func convertToMonthYearFormat() -> String? {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MMM yyyy"
		dateFormatter.locale = Locale.current
		
		return dateFormatter.string(from: self)
	}
}
