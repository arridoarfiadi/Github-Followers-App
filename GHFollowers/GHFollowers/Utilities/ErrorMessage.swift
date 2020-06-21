//
//  ErrorMessage.swift
//  GHFollowers
//
//  Created by Arrido Arfiadi on 2/3/20.
//  Copyright © 2020 Arrido Arfiadi. All rights reserved.
//

import Foundation


enum GFError: String, Error {
	case invalidUsername = "This username created an invalid request url. Please try again"
	case unableToComplete = "Unable to complete your request. Please check your internet"
	case invalidResponse = "Invalid Server Response"
	case invalidData = "The data recieved is invalid"
	case unableToFavorite = "Unable to favorite"
	case alreadyInFavorite = "Already save in favorite"
}
