//
//  Follower.swift
//  GHFollowers
//
//  Created by Arrido Arfiadi on 2/2/20.
//  Copyright © 2020 Arrido Arfiadi. All rights reserved.
//

import Foundation

struct Follower: Codable {
	var login: String
	var avatarUrl: String
	
//	enum CodingKeys: String, CodingKey {
//		case username = "login"
//		case avatarUrl = "avatar_url"
//	}
}
