//
//  MovieTrailerButtonView.swift
//  HBO Max Clone
//
//  Created by Caleb Wells on 3/20/23.
//

import SwiftUI

struct MovieTrailerButtonView: View {
    @Binding var isTrailerPlaying: Bool
    let viewModel: MovieViewModel
    
    var body: some View {
        if viewModel.trailerPreviewUrl != nil {
            Button {
                isTrailerPlaying.toggle()
            } label: {
                Label("Trailer", systemImage: "play.rectangle.fill")
            }
            .foregroundColor(Color(.label))
            .padding(.vertical)
            
        } else {
            Text("No trailer available")
                .foregroundColor(.red)
                .padding(.vertical)
        }
    }
}

struct MovieTrailerView_Previews: PreviewProvider {
    static var previews: some View {
        MovieTrailerButtonView(isTrailerPlaying: .constant(false), viewModel: SampleData().viewModel)
            .previewLayout(.sizeThatFits)
    }
}
