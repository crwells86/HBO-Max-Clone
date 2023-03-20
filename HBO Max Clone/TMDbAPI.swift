//
//  TMDbAPI.swift
//  HBO Max Clone
//
//  Created by Caleb Wells on 3/20/23.
//

import Foundation
import Combine

struct TMDbAPI {
    let apiKey = "616ec7a808b5f081d10ab2e0541642fe"
    let baseURL = "https://api.themoviedb.org/3"
    let jsonDecoder = JSONDecoder()
    
    /// Searches for a movie by query
    func searchMovie(query: String) -> AnyPublisher<MovieResponse, Error> {
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "\(baseURL)/search/movie?api_key=\(apiKey)&query=\(encodedQuery)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: MovieResponse.self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }
    
    /// Fetches detailed information of a movie by its id
    func getMovieDetails(movieId: Int) -> AnyPublisher<Movie, Error> {
        guard let url = URL(string: "\(baseURL)/movie/\(movieId)?api_key=\(apiKey)&append_to_response=genres,runtime") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Movie.self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }
    
    /// Fetches the list of genres
    func getGenres() -> AnyPublisher<[Genre], Error> {
        guard let url = URL(string: "\(baseURL)/genre/movie/list?api_key=\(apiKey)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: GenresResponse.self, decoder: jsonDecoder)
            .map { $0.genres }
            .eraseToAnyPublisher()
    }
}

