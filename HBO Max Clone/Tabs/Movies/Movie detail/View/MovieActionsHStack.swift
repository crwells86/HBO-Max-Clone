//
//  MovieActionsHStack.swift
//  HBO Max Clone
//
//  Created by Caleb Wells on 3/20/23.
//

import SwiftUI

struct MovieActionsHStack: View {
//    let image: String
//    let action: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: "play.circle")
                .font(.largeTitle)
            
            Spacer()
            
            Button {
                // ?
            } label: {
                Image(systemName: "plus")
                    .font(.title2)
            }
            .padding(.trailing)
            
            Button {
                // ?
            } label: {
                Image(systemName: "arrow.down.to.line.alt")
                    .font(.title2)
            }
        }
        .padding(.vertical, 8)
        .foregroundColor(.primary)
    }
}

struct MovieActionsHStack_Previews: PreviewProvider {
    static var previews: some View {
        MovieActionsHStack()
            .previewLayout(.sizeThatFits)
    }
}
