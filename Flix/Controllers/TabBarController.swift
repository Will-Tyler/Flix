//
//  TabBarController.swift
//  Flix
//
//  Created by Will Tyler on 1/24/19.
//  Copyright © 2019 Will Tyler. All rights reserved.
//

import UIKit


class TabBarController: UITabBarController {

	private lazy var movies: UINavigationController = {
		let nav = UINavigationController(rootViewController: MoviesViewController())

		nav.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
		nav.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
		nav.navigationBar.barTintColor = UIColor(white: 0x40 / 255, alpha: 1)

		return nav
	}()
	private lazy var superheroes: UINavigationController = {
		let nav = UINavigationController(rootViewController: SuperheroesViewController())

		nav.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
		nav.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
		nav.navigationBar.barTintColor = UIColor(white: 0x40 / 255, alpha: 1)

		return nav
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = UIColor(white: 55 / 255, alpha: 1)
		tabBar.barTintColor = UIColor(white: 0x40 / 255, alpha: 1)

		setViewControllers([movies, superheroes], animated: false)
	}

}
