//
//  MovieDetailsScrollView.swift
//  HBO Max Clone
//
//  Created by Caleb Wells on 3/20/23.
//

import SwiftUI

struct MovieDetailsScrollView: View {
    let movie: Movie
    let viewModel: MovieViewModel
    
    var body: some View {
        ScrollView {
            ZStack {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                
                LinearGradient(gradient: Gradient(colors: [.clear, Color(.systemBackground)]), startPoint: .top, endPoint: .bottom)
                    .overlay(alignment: .bottom) {
                        MovieDetailsOverlay(movie: movie, viewModel: viewModel)
                    }
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct MovieDetailsScrollView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsScrollView(movie: SampleData().sampleMovie, viewModel: SampleData().viewModel)
    }
}
