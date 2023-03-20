//
//  MovieDetailsOverlay.swift
//  HBO Max Clone
//
//  Created by Caleb Wells on 3/20/23.
//

import SwiftUI
import AVKit

struct MovieDetailsOverlay: View {
    @State private var isTrailerPlaying = false
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
            
            MovieTrailerButtonView(isTrailerPlaying: $isTrailerPlaying, viewModel: viewModel)
        }
        .padding()
        .fullScreenCover(isPresented: $isTrailerPlaying) {
            //TODO: Work on a better video player. 🤔
            VideoPlayer(player: AVPlayer(url: viewModel.trailerPreviewUrl!)) {
                Button {
                    isTrailerPlaying.toggle()
                } label: {
                    Image(systemName: "xmark")
                }
                .foregroundColor(Color(.red))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding()
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct MovieDetailsOverlay_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsOverlay(movie: SampleData().sampleMovie, viewModel: SampleData().viewModel)
            .previewLayout(.sizeThatFits)
    }
}
