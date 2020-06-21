//
//  PersistenceManager.swift
//  GHFollowers
//
//  Created by Arrido Arfiadi on 6/15/20.
//  Copyright © 2020 Arrido Arfiadi. All rights reserved.
//

import Foundation

enum PersistenceActionType {
	case add, remove
}

enum PersistenceManager {
	static private let defaults = UserDefaults.standard
	
	enum Keys {
		static let favorites = "favorites"
	}
	
	static func update(with favorite: Follower, actionType: PersistenceActionType, completion: @escaping (GFError?) -> Void) {
		retrieveFavorites { (result) in
			switch result {
			case .success(let favorites):
				var retrievedFavorites = favorites
				switch actionType {
				case .add:
					guard !retrievedFavorites.contains(favorite) else {
						completion(.alreadyInFavorite)
						return
					}
					retrievedFavorites.append(favorite)
				case .remove:
					retrievedFavorites.removeAll(where: {$0.login == favorite.login})
				}
				completion(save(favorites: retrievedFavorites))
			case .failure(let error): completion(error)
			}
		}
	}
	
	static func retrieveFavorites(completion: @escaping (Result<[Follower], GFError>) -> Void) {
		guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
			completion(.success([]))
			return
		}
		do {
			let decoder = JSONDecoder()
			let followers = try decoder.decode([Follower].self, from: favoritesData)
			completion(.success(followers))
		} catch {
			completion(.failure(.unableToFavorite))
		}
	}
	
	static func save(favorites: [Follower]) -> GFError? {
		do {
			let encoder = JSONEncoder()
			let encodedFavorites = try encoder.encode(favorites)
			defaults.set(encodedFavorites, forKey: Keys.favorites)
			return nil
		} catch {
			return .unableToFavorite
		}
	}
}
