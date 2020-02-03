//
//  User.swift
//  GHFollowers
//
//  Created by Arrido Arfiadi on 2/2/20.
//  Copyright © 2020 Arrido Arfiadi. All rights reserved.
//

import Foundation

struct User: Codable {
	var login: String
	var avatarUrl: String
	var name: String?
	var location: String?
	var bio: String?
	var publicRepos: Int
	var publicGists: Int
	var htmlUrl: String
	var followers: Int
	var following: Int
	var createdAt: String
}

