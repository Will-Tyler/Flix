//
//  ViewController.swift
//  Flix
//
//  Created by Will Tyler on 1/14/19.
//  Copyright © 2019 Will Tyler. All rights reserved.
//

import UIKit


final class ViewController: UITableViewController {

	private var movies = [Movie]() {
		didSet {
			tableView.reloadData()
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .white

		loadMovies()

		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.cellID)
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
		}

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

		cell.textLabel?.text = movie.title

		let baseURL = URL(string: "https://image.tmdb.org/t/p/w185")!
		let posterPath = movie.posterPath
		let posterURL = baseURL.appendingPathComponent(posterPath.absoluteString)

		return cell
	}

}
