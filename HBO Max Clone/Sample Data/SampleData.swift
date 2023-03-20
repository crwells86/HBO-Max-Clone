//
//  SampleData.swift
//  HBO Max Clone
//
//  Created by Caleb Wells on 3/20/23.
//

import Foundation

struct SampleData {
    let sampleMovie = Movie(id: 0,
                            title: "The Matrix",
                            overview: "Set in the 22nd century, The Matrix tells the story of a computer hacker who joins a group of underground insurgents fighting the vast and powerful computers who now rule the earth.",
                            posterPath: "https://image.tmdb.org/t/p/w500//f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg",
                            voteAverage: 8.198,
                            adult: false,
                            backdropPath: nil,
                            runtime: 136,
                            genreIds: [16],
                            originalLanguage: "en",
                            originalTitle: "The Matrix",
                            popularity: 0,
                            releaseDate: "1999-03-30",
                            video: false,
                            voteCount: 22923)
    
    
    let viewModel = MovieViewModel()
}
