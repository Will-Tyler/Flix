//
//  ViewController.swift
//  Flix
//
//  Created by Will Tyler on 1/14/19.
//  Copyright © 2019 Will Tyler. All rights reserved.
//

import UIKit
import AlamofireImage


final class MoviesViewController: UITableViewController {

	private lazy var detailController = MovieViewController()

	convenience init() {
		self.init(nibName: nil, bundle: nil)
	}
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

		title = "Movies"
		tabBarItem.image = UIImage(named: "now_playing_tabbar_item")
		tabBarItem.title = "Now Playing"
	}
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = UIColor(white: 55 / 255, alpha: 1)

		loadMovies()

		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.cellID)
	}

	override var prefersStatusBarHidden: Bool {
		get {
			return shouldHideStatusBar
		}
	}

	private var movies = [Movie]() {
		didSet {
			tableView.reloadData()
		}
	}

	private func loadMovies() {
		let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
		let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
		let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
		let task = session.dataTask(with: request) { (data, response, error) in
			if let error = error {
				print(error.localizedDescription)
			}
			else if let data = data {
				let dict = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

				if let results = dict["results"] {
					self.movies = try! JSONDecoder().decode([Movie].self, from: JSONSerialization.data(withJSONObject: results))
				}
			}

			UIApplication.shared.isNetworkActivityIndicatorVisible = false
		}

		UIApplication.shared.isNetworkActivityIndicatorVisible = true
		task.resume()
	}

	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return movies.count
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let movie = movies[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.cellID, for: indexPath) as! MovieTableViewCell

		cell.titleLabel.text = movie.title
		cell.synopsisLabel.text = movie.overview

		let baseURL = URL(string: "https://image.tmdb.org/t/p/w185")!
		let posterPath = movie.posterPath
		let posterURL = baseURL.appendingPathComponent(posterPath.absoluteString)

		cell.posterView.af_setImage(withURL: posterURL)

		return cell
	}
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 128
	}
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		detailController.movie = movies[indexPath.row]
		navigationController?.pushViewController(detailController, animated: true)
		tableView.deselectRow(at: indexPath, animated: true)
	}

	private var shouldHideStatusBar = false
	override func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
		shouldHideStatusBar = false
		setNeedsStatusBarAppearanceUpdate()
	}
	override func scrollViewDidScroll(_ scrollView: UIScrollView) {
		if scrollView.panGestureRecognizer.translation(in: scrollView.superview).y < 0 {
			shouldHideStatusBar = true
			setNeedsStatusBarAppearanceUpdate()
		}
		else {
			shouldHideStatusBar = false
			setNeedsStatusBarAppearanceUpdate()
		}
	}

}
