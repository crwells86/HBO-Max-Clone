//
//  MovieViewModel.swift
//  HBO Max Clone
//
//  Created by Caleb Wells on 3/20/23.
//

import Combine
import Foundation

class MovieViewModel: ObservableObject {
    @Published private(set) var movie: Movie?
    @Published private(set) var genreName = String()
    @Published private(set) var trailerPreviewUrl: URL?
    var genres = [Int: String]()
    private var cancellables = Set<AnyCancellable>()
    
    /// Fetch movie details based on the query string and update the MovieViewModel's properties accordingly
    func fetchMovieDetails(api: TMDbAPI, query: String) {
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        let urlString = "\(api.baseURL)/search/movie?api_key=\(api.apiKey)&query=\(encodedQuery)"
        
        api.fetchData(urlString: urlString)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching movie search results: \(error.localizedDescription)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] (response: MovieResponse) in
                guard let movie = response.results.first else {
                    print("No movie found with the given query.")
                    return
                }
                
                self?.fetchDetailedMovie(api: api, movieId: movie.id)
                self?.fetchGenres(api: api)
                self?.genreName = self?.genreNames(from: movie.genreIds ?? [0]).first ?? ""
            }
            .store(in: &cancellables)
    }
    
    
    /// Convert the given duration in minutes to a formatted string representing hours and minutes
    func formatMinutesToHoursAndMinutes(_ minutes: Int) -> String {
        let hours = minutes / 60
        let remainingMinutes = minutes % 60
        return String(format: "%d HR %02d MIN", hours, remainingMinutes)
    }
    
    /// Fetch the list of genres from the API and update the MovieViewModel's genres dictionary accordingly
    func fetchGenres(api: TMDbAPI) {
        api.getGenres()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching genres: \(error.localizedDescription)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] genres in
                self?.genres = Dictionary(uniqueKeysWithValues: genres.map { ($0.id, $0.name) })
            }
            .store(in: &cancellables)
    }
    
    /// Get a list of genre names corresponding to the provided genre IDs
    func genreNames(from genreIds: [Int]) -> [String] {
        return genreIds.compactMap { genres[$0] }
    }
    
    private func fetchTrailer(for movieTitle: String, api: ITunesAPI) {
        api.search(term: movieTitle)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching movie trailer: \(error.localizedDescription)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] (response: ITunesSearchResponse) in
                if let previewUrlString = response.results.first?.previewUrl,
                   let previewUrl = URL(string: previewUrlString) {
                    self?.trailerPreviewUrl = previewUrl
                } else {
                    print("No movie trailer found with the given movie title.")
                }
            }
            .store(in: &cancellables)
    }
    
    private func fetchDetailedMovie(api: TMDbAPI, movieId: Int) {
        let urlString = "\(api.baseURL)/movie/\(movieId)?api_key=\(api.apiKey)&append_to_response=genres,runtime"
        
        api.fetchData(urlString: urlString)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching movie details: \(error.localizedDescription)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] (movie: Movie) in
                self?.movie = movie
                self?.fetchTrailer(for: movie.title, api: ITunesAPI())
            }
            .store(in: &cancellables)
    }
}
