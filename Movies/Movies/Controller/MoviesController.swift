//
//  MovesController.swift
//  Movies
//
//  Created by Lucas Flores on 19/03/19.
//  Copyright © 2019 lucas.flores. All rights reserved.
//

import Foundation
import SwiftyJSON

class MoviesController {
    private let service: Service = Service()
    private var movie_genres: [String : String] = [String : String]()
    
    init() {
        self.getGenres { genres in
            self.movie_genres = genres
        }
    }
    
    public func getMoviesData(page: Int = 1, completion: @escaping(_ data : [Movie], Int) -> ()){
        self.service.requestUpcomingMovies(page: page, completion: { (response, totalPages) in
            var movies: [Movie] = [Movie]()
            
            for movie in response{
                let title: String = movie["title"].string ?? ""
                let poster:URL = URL(string: "https://image.tmdb.org/t/p/w300\(movie["poster_path"].string ?? "")")!
                var genres: String? = nil
                
                for genre in JSON(movie["genre_ids"]).array!{
                    if genres != nil{
                        genres = "\(genres ?? ""), \(self.movie_genres[genre.description] ?? "")"
                    }
                    else {
                        genres = self.movie_genres[genre.description] ?? ""
                    }
                }
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let auxDate: Date = dateFormatter.date(from: movie["release_date"].string ?? "")!
                dateFormatter.dateFormat = "MM/dd/yyyy"
                let releaseDate: String = dateFormatter.string(from: auxDate)
                
                let overview: String = movie["overview"].string ?? ""
                
                movies.append(Movie(title: title, poster: poster, genres: genres ?? "", releaseDate: releaseDate, overview: overview))
            }
            
            completion(movies, totalPages)
            
        })
    }
    
    public func getGenres(completion: @escaping(_ data : [String : String]) -> ()){
        self.service.requestMoviesGenre(completion: { response in
            
            var genres: [String: String] = [String : String]()
            
            for genre in response{
                genres[genre["id"].description] = genre["name"].string ?? ""
            }
            
            completion(genres)
        })
    }
}
