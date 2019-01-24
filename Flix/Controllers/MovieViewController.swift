//
//  MovieViewController.swift
//  Flix
//
//  Created by Will Tyler on 1/23/19.
//  Copyright © 2019 Will Tyler. All rights reserved.
//

import UIKit
import AlamofireImage


class MovieViewController: UIViewController {

	private lazy var backdropView: UIImageView = {
		let image = UIImageView()

		image.clipsToBounds = true
		image.contentMode = .scaleAspectFit

		return image
	}()
	private lazy var posterView: UIImageView = {
		let image = UIImageView()

		image.clipsToBounds = true
		image.contentMode = .scaleAspectFit

		return image
	}()
	private lazy var titleLabel: UILabel = {
		let label = UILabel()

		label.font = .boldSystemFont(ofSize: 22)
		label.textColor = .white
		label.numberOfLines = 0

		return label
	}()
	private lazy var overviewLabel: UITextView = {
		let label = UITextView()

		label.textColor = .white
		label.isEditable = false
		label.backgroundColor = .clear
		label.font = UIFont.systemFont(ofSize: UIFont.labelFontSize)

		return label
	}()

	private func setupInitialLayout() {
		view.addSubview(backdropView)
		view.addSubview(posterView)
		view.addSubview(titleLabel)
		view.addSubview(overviewLabel)

		let safeArea = view.safeAreaLayoutGuide

		backdropView.translatesAutoresizingMaskIntoConstraints = false
		backdropView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
		backdropView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
		backdropView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
		backdropView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 1 / 3).isActive = true

		posterView.translatesAutoresizingMaskIntoConstraints = false
		posterView.centerYAnchor.constraint(equalTo: backdropView.bottomAnchor).isActive = true
		posterView.heightAnchor.constraint(equalToConstant: 128).isActive = true
		posterView.widthAnchor.constraint(equalTo: posterView.heightAnchor, multiplier: 2 / 3).isActive = true
		posterView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8).isActive = true

		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.topAnchor.constraint(equalTo: backdropView.bottomAnchor).isActive = true
		titleLabel.leadingAnchor.constraint(equalTo: posterView.trailingAnchor, constant: 8).isActive = true
		titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8).isActive = true
		titleLabel.heightAnchor.constraint(equalToConstant: titleLabel.intrinsicContentSize.height).isActive = true

		overviewLabel.translatesAutoresizingMaskIntoConstraints = false
		overviewLabel.topAnchor.constraint(equalTo: posterView.bottomAnchor, constant: 8).isActive = true
		overviewLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8).isActive = true
		overviewLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8).isActive = true
		overviewLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -8).isActive = true
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = UIColor.black

		setupInitialLayout()
	}

	var movie: Movie! {
		didSet {
			title = movie.title
			titleLabel.text = movie.title
			overviewLabel.text = movie.overview

			let baseURL = URL(string: "https://image.tmdb.org/t/p/w185")!
			let posterPath = movie.posterPath
			let posterURL = baseURL.appendingPathComponent(posterPath.absoluteString)
			let backdropPath = movie.backdropPath
			let backdropURL = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath.absoluteString)!

			posterView.af_setImage(withURL: posterURL)
			backdropView.af_setImage(withURL: backdropURL)
		}
	}

}
