//
//  SuperheroCollectionViewCell.swift
//  Flix
//
//  Created by Will Tyler on 1/24/19.
//  Copyright © 2019 Will Tyler. All rights reserved.
//

import UIKit


class SuperheroCollectionViewCell: UICollectionViewCell {

	lazy var posterView: UIImageView = {
		let image = UIImageView()

		image.clipsToBounds = true
		image.contentMode = .scaleAspectFit

		return image
	}()

	private func setupInitialLayout() {
		addSubview(posterView)

		posterView.translatesAutoresizingMaskIntoConstraints = false
		posterView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		posterView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		posterView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		posterView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		backgroundColor = .clear
		setupInitialLayout()
	}

	static let cellID = "SuperheroCollectionViewCell"

}
