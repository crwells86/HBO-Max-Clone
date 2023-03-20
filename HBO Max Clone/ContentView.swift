//
//  ContentView.swift
//  HBO Max Clone
//
//  Created by Caleb Wells on 3/20/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            // Home
            Text("Tab Content 1")
                .tabItem {
                    Image(systemName: "house")
                }
                .tag(1)
            
            // Movies
            Text("Tab Content 2")
                .tabItem {
                    Image(systemName: "film")
                }
                .tag(2)
            
            // Series
            Text("Tab Content 3")
                .tabItem {
                    Image(systemName: "tv")
                }
                .tag(3)
            
            // Downloads
            Text("Tab Content 4")
                .tabItem {
                    Image(systemName: "arrow.down")
                }
                .tag(4)
            
            // Search
            Text("Tab Content 5")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
                .tag(5)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
