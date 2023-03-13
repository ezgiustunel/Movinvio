//
//  MovieVM.swift
//  Movinvio
//
//  Created by Ezgi Üstünel on 4.06.2022.
//

import Foundation
import UIKit

struct MovieVM {
    let movie: Movie
    let title: String
    let genre: String
    let detail: String
    let posterURL: String
    
    // MARK: - View Lifecycle
    init(movie: Movie) {
        self.movie = movie
        self.title = movie.title
        self.genre = movie.genre
        self.detail = movie.detail
        self.posterURL = movie.posterURL
    }
}

extension MovieVM {
    var searchText: String {
        return "\(String(describing: title)) \(String(describing: genre)) \(String(describing: detail))"
    }
}
