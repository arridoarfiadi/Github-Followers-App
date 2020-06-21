//
//  GFTabBarController.swift
//  GHFollowers
//
//  Created by Arrido Arfiadi on 6/21/20.
//  Copyright © 2020 Arrido Arfiadi. All rights reserved.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
		UITabBar.appearance().tintColor = .systemGreen
		viewControllers = [createSearchNC(), createFavouritesNC()]
    }
    
	
	func createSearchNC() -> UINavigationController {
		let searchVC = SearchVC()
		searchVC.title = "Search"
		searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
		return UINavigationController(rootViewController: searchVC)
	}
	
	func createFavouritesNC() -> UINavigationController {
		let favouritesListVC = FavouritesListVC()
		favouritesListVC.title = "Favourite"
		favouritesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
		return UINavigationController(rootViewController: favouritesListVC)
	}
}
