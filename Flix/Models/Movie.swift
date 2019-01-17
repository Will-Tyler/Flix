//
//  Movie.swift
//  Flix
//
//  Created by Will Tyler on 1/15/19.
//  Copyright © 2019 Will Tyler. All rights reserved.
//

import Foundation


struct Movie: Decodable {

	let voteCount: Int
	let id: Int
	let isVideo: Bool
	let voteAverage: Double
	let title: String
	let popularity: Double
	let posterPath: URL
	let originalLanguage: String
	let originalTitle: String
	let genreIDs: [Int]
	let backdropPath: URL
	let isAdult: Bool
	let overview: String
	let releaseDate: String

	private enum CodingKeys: String, CodingKey {

		case voteCount = "vote_count"
		case id
		case isVideo = "video"
		case voteAverage = "vote_average"
		case title
		case popularity
		case posterPath = "poster_path"
		case originalLanguage = "original_language"
		case originalTitle = "original_title"
		case genreIDs = "genre_ids"
		case backdropPath = "backdrop_path"
		case isAdult = "adult"
		case overview
		case releaseDate = "release_date"

	}

}
