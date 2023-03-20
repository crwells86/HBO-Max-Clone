//
//  ITunesAPI.swift
//  HBO Max Clone
//
//  Created by Caleb Wells on 3/20/23.
//

import Foundation
import Combine

struct ITunesAPI {
    let baseURL = "https://itunes.apple.com/search?term="
    let jsonDecoder = JSONDecoder()
    
    /// Fetches data from the specified URL and decodes it into a generic Decodable type.
    /// - Parameter urlString: A string representing the URL to fetch data from.
    /// - Returns: A publisher emitting the decoded data of the specified generic Decodable type, or an error if the data could not be fetched or decoded.
    func fetchData<T>(urlString: String) -> AnyPublisher<T, Error> where T : Decodable {
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }
    
    /// Fetches the search results for a given term from the iTunes Search API.
    /// - Parameter term: The search term to query the iTunes Search API.
    /// - Returns: A publisher emitting the search results as an `ITunesSearchResponse` object, or an error if the data could not be fetched or decoded.
    func search(term: String) -> AnyPublisher<ITunesSearchResponse, Error> {
        guard let encodedTerm = term.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        let urlString = "\(baseURL)\(encodedTerm)&entity=movie"
        
        return fetchData(urlString: urlString)
            .eraseToAnyPublisher()
    }
}

struct ITunesSearchResponse: Decodable {
    let resultCount: Int
    let results: [ITunesItem]
}

struct ITunesItem: Decodable {
    let previewUrl: String?
}
