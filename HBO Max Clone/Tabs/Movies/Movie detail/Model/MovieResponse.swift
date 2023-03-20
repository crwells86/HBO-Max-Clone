//
//  MovieResponse.swift
//  HBO Max Clone
//
//  Created by Caleb Wells on 3/20/23.
//

import Foundation

struct MovieResponse: Decodable {
    let page: Int
    let results: [Movie]
}
