//
//  Movie.swift
//  Movies
//
//  Created by Lucas Flores on 19/03/19.
//  Copyright © 2019 lucas.flores. All rights reserved.
//

import Foundation

class Movie{
    
    let title: String
    let poster: URL
    let genres: String
    let releaseDate: String
    let overview: String
    
    init(title: String, poster: URL, genres: String, releaseDate: String, overview: String) {
        self.title = title
        self.poster = poster
        self.genres = genres
        self.releaseDate = releaseDate
        self.overview = overview
    }
    
    public func description() -> String {
        return "Title: \(self.title)\nPoster: \(self.poster.description)\nGenres: \(self.genres)\nRelease date: \(self.releaseDate)\nOverview: \(self.overview)"
    }
}
