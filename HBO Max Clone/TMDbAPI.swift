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
    
    /// Fetches data from the specified URL and decodes it into a generic Decodable type.
    /// - Parameter urlString: A string representing the URL to fetch data from.
    /// - Returns: A publisher emitting the decoded data of the specified generic Decodable type, or an error if the data could not be fetched or decoded.
    func fetchData<T: Decodable>(urlString: String) -> AnyPublisher<T, Error> {
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: jsonDecoder)
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
