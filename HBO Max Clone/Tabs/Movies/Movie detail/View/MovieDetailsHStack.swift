//
//  MovieDetailsHStack.swift
//  HBO Max Clone
//
//  Created by Caleb Wells on 3/20/23.
//

import SwiftUI

struct MovieDetailsHStack: View {
    let movie: Movie
    let viewModel: MovieViewModel
    
    var body: some View {
        HStack {
            Text("\(viewModel.formatMinutesToHoursAndMinutes(movie.runtime ?? 0))")
                .font(.headline)
            
            Text(viewModel.genreName)
                .font(.headline)
            
            Text("\(movie.releaseDate)".dropLast(6))
                .font(.headline)
            
            Text("4K")
                .font(.headline)
            
            Text("5.1")
                .font(.headline)
        }
    }
}

struct MovieDetailsHStack_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsHStack(movie: SampleData().sampleMovie, viewModel: SampleData().viewModel)
            .previewLayout(.sizeThatFits)
    }
}
