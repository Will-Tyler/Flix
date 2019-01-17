//
//  MovieTableViewCell.swift
//  Flix
//
//  Created by Will Tyler on 1/17/19.
//  Copyright © 2019 Will Tyler. All rights reserved.
//

import UIKit


final class MovieTableViewCell: UITableViewCell {

	lazy var posterView: UIImageView = {
		let image = UIImageView()

		image.clipsToBounds = true
		image.contentMode = .scaleAspectFit

		return image
	}()
	lazy var titleLabel: UILabel = {
		let label = UILabel()

		label.font = UIFont.boldSystemFont(ofSize: 24)
		label.textColor = .white

		return label
	}()
	lazy var synopsisLabel: UILabel = {
		let label = UILabel()

		label.numberOfLines = 0
		label.textColor = .white

		return label
	}()

	private func setupInitialLayout() {
		addSubview(posterView)
		addSubview(titleLabel)
		addSubview(synopsisLabel)

		posterView.translatesAutoresizingMaskIntoConstraints = false
		posterView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
		posterView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
		posterView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
		posterView.widthAnchor.constraint(equalToConstant: 64).isActive = true

		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.topAnchor.constraint(equalTo: posterView.topAnchor).isActive = true
		titleLabel.leadingAnchor.constraint(equalTo: posterView.trailingAnchor, constant: 8).isActive = true
		titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
		titleLabel.heightAnchor.constraint(equalToConstant: titleLabel.intrinsicContentSize.height).isActive = true

		synopsisLabel.translatesAutoresizingMaskIntoConstraints = false
		synopsisLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
		synopsisLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
		synopsisLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
		synopsisLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		backgroundColor = .clear

		setupInitialLayout()
	}

	static let cellID = "MovieTableViewCell"
	
}
