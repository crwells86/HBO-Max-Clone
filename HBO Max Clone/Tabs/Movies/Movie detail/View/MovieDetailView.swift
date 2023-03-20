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
    
    //TODO: Move search to another view, this is just for testing.
    @State private var searchQuery = ""
    
    var body: some View {
        VStack {
            if let movie = viewModel.movie {
                MovieDetailsScrollView(movie: movie, viewModel: viewModel)
            } else {
                Text("Loading...")
            }
            
            TextField("Search", text: $searchQuery)
                .textFieldStyle(.roundedBorder)
                .padding()
                .onSubmit {
                    viewModel.fetchMovieDetails(api: api, query: searchQuery)
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
