//
//  MovieDetailView.swift
//  HBO Max Clone
//
//  Created by Caleb Wells on 3/20/23.
//

import SwiftUI

struct MovieDetailView: View {
    @StateObject private var viewModel = MovieViewModel()
    private let api = TMDbAPI()
    
    var body: some View {
        VStack {
            if let movie = viewModel.movie {
                MovieDetailsScrollView(movie: movie, viewModel: viewModel)
            } else {
                Text("Loading...")
            }
        }
        .onAppear {
            viewModel.fetchMovieDetails(api: api, query: "Office Space")
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView()
    }
}
