//
//  MovieDetailsOverlay.swift
//  HBO Max Clone
//
//  Created by Caleb Wells on 3/20/23.
//

import SwiftUI

struct MovieDetailsOverlay: View {
    let movie: Movie
    let viewModel: MovieViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(movie.title)
                .font(.largeTitle)
            
            MovieDetailsHStack(movie: movie, viewModel: viewModel)
            
            MovieActionsHStack()
            
            Text(movie.overview)
                .font(.body)
        }
        .padding()
    }
}

struct MovieDetailsOverlay_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsOverlay(movie: SampleData().sampleMovie, viewModel: SampleData().viewModel)
            .previewLayout(.sizeThatFits)
    }
}
