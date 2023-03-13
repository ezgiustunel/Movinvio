//
//  Movie.swift
//  Movinvio
//
//  Created by Ezgi Üstünel on 4.06.2022.
//

import Foundation

struct Movie: Codable {
    var title: String
    var genre: String
    var detail: String
    var posterURL: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case genre = "Genre"
        case detail = "Plot"
        case posterURL = "Poster"
    }
    
    init() {
        title = ""
        genre = ""
        detail = ""
        posterURL = ""
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        genre = try container.decode(String.self, forKey: .genre)
        detail = try container.decode(String.self, forKey: .detail)
        posterURL = try container.decode(String.self, forKey: .posterURL)
    }
}
