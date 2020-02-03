//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Arrido Arfiadi on 1/31/20.
//  Copyright © 2020 Arrido Arfiadi. All rights reserved.
//

import UIKit

class FollowerListVC: UIViewController {
	var username: String!
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .systemBackground
    }
    
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationController?.setNavigationBarHidden(true, animated: true)
	}

}
