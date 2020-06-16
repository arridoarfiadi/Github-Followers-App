//
//  User.swift
//  GHFollowers
//
//  Created by Arrido Arfiadi on 2/2/20.
//  Copyright © 2020 Arrido Arfiadi. All rights reserved.
//

import Foundation

struct User: Codable {
	let login: String
	var avatarUrl: String
	var name: String?
	var location: String?
	var bio: String?
	let publicRepos: Int
	let publicGists: Int
	let htmlUrl: String
	let followers: Int
	let following: Int
	let createdAt: String
}

