//
//  MovieViewModel.swift
//  HBO Max Clone
//
//  Created by Caleb Wells on 3/20/23.
//

import Combine

class MovieViewModel: ObservableObject {
    @Published var movie: Movie?
    @Published var genreName = String()
    var genres = [Int: String]()
    private var cancellables = Set<AnyCancellable>()
    
    /// Fetch movie details based on the query string and update the MovieViewModel's properties accordingly
    func fetchMovieDetails(api: TMDbAPI, query: String) {
        api.searchMovie(query: query)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching movie search results: \(error.localizedDescription)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] response in
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
    
    /// Fetch detailed information for a movie by its ID and update the MovieViewModel's movie property accordingly
    private func fetchDetailedMovie(api: TMDbAPI, movieId: Int) {
        api.getMovieDetails(movieId: movieId)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching movie details: \(error.localizedDescription)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] movie in
                self?.movie = movie
            }
            .store(in: &cancellables)
    }
}
