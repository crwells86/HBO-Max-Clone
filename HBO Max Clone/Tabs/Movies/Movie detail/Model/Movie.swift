//
//  Movie.swift
//  HBO Max Clone
//
//  Created by Caleb Wells on 3/20/23.
//

import Foundation

struct Movie: Decodable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let voteAverage: Double
    let adult: Bool
    let backdropPath: String?
    let runtime: Int?
    let genreIds: [Int]?
    let originalLanguage: String
    let originalTitle: String
    let popularity: Double
    let releaseDate: String
    let video: Bool
    let voteCount: Int
}
