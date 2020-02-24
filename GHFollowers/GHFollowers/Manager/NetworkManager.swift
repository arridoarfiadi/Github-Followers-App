//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Arrido Arfiadi on 2/3/20.
//  Copyright © 2020 Arrido Arfiadi. All rights reserved.
//

import UIKit

class NetworkManager {
	static let shared = NetworkManager()
	private init() {}
	private let baseURL = "https://api.github.com"
	let cache = NSCache<NSString, UIImage>()
	
	
	let perPageDefault = 100
	func getFollowers(for username: String, page: Int, completion: @escaping (Result<[Follower], GFError>) -> Void) {
		let endpoint = baseURL + "/users/\(username)/followers?per_page=\(perPageDefault)&page=\(page)"
		guard let url = URL(string: endpoint) else {
			//completion(nil, .invalidUsername)
			completion(.failure(.invalidUsername))
			return
		}
		let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
			if let _ =  error {
				//completion(nil, .unableToComplete)
				completion(.failure(.unableToComplete))
			}
			
			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
				//completion(nil, .invalidResponse)
				completion(.failure(.invalidResponse))
				return
			}
			
			guard let data = data else {
				//completion(nil, .invalidData)
				completion(.failure(.invalidData))
				return
			}
			
			do {
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				let followers = try decoder.decode([Follower].self, from: data)
				//completion(followers, nil)
				completion(.success(followers))
			} catch {
				//completion(nil, .invalidData)
				completion(.failure(.invalidData))
			}
			
		}
		task.resume()
		
		
	}
}
