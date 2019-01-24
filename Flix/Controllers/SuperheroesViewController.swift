//
//  SuperheroesViewController.swift
//  Flix
//
//  Created by Will Tyler on 1/24/19.
//  Copyright © 2019 Will Tyler. All rights reserved.
//

import UIKit
import AlamofireImage


class SuperheroesViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

		title = "Superheroes"
		tabBarItem.image = UIImage(named: "superhero_tabbar_item")
	}
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private lazy var detailController = MovieViewController()
	private lazy var collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()

		layout.minimumLineSpacing = 4
		layout.minimumInteritemSpacing = 4

		let width = view.frame.width / 2 - 2

		layout.itemSize = CGSize(width: width, height: 3/2 * width)

		let collection = UICollectionView(frame: view.frame, collectionViewLayout: layout)

		collection.delegate = self
		collection.dataSource = self
		collection.register(SuperheroCollectionViewCell.self, forCellWithReuseIdentifier: SuperheroCollectionViewCell.cellID)
		collection.backgroundColor = .clear

		return collection
	}()

	private func setupInitialLayout() {
		view.addSubview(collectionView)

		let safeArea = view.safeAreaLayoutGuide

		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
		collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
		collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
		collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = UIColor(white: 55 / 255, alpha: 1)
		setupInitialLayout()
		loadMovies()
	}

	private var movies: [Movie] = [] {
		didSet {
			collectionView.reloadData()
		}
	}

	private func loadMovies() {
		let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
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

	// Collection view
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return movies.count
	}
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SuperheroCollectionViewCell.cellID, for: indexPath) as! SuperheroCollectionViewCell
		let movie = movies[indexPath.row]

		let baseURL = URL(string: "https://image.tmdb.org/t/p/w185")!
		let posterPath = movie.posterPath
		let posterURL = baseURL.appendingPathComponent(posterPath.absoluteString)

		cell.posterView.af_setImage(withURL: posterURL)

		return cell
	}
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		detailController.movie = movies[indexPath.row]
		navigationController?.pushViewController(detailController, animated: true)
		collectionView.deselectItem(at: indexPath, animated: true)
	}

}
