//
//  Service.swift
//  Movies
//
//  Created by Lucas Flores on 18/03/19.
//  Copyright © 2019 lucas.flores. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Service {
    private let apiURL: String = "https://api.themoviedb.org/3/"
    private let apiKey: String = "c5850ed73901b8d268d0898a8a9d8bff"
    private let apiLanguage: String = "en-US"
    
    public func requestUpcomingMovies(page: Int = 1, completion: @escaping ([JSON]) -> ()) -> (){
        
        let upcomingMoviesURL = "\(apiURL)movie/upcoming?api_key=\(apiKey)&page=\(page.description)"
        
        Alamofire.request(upcomingMoviesURL).responseJSON { response in
            
            if let json = response.result.value {
                let jsonResponse = JSON(json)
                
                if let resData = jsonResponse["results"].array {
                    completion(resData)
                }
            }
        }
    }
    
    public func requestMoviesGenre(completion: @escaping ([JSON]) -> ()) -> (){
        
        let moviesGenreURL = "\(apiURL)genre/movie/list?api_key=\(apiKey)"
        
        Alamofire.request(moviesGenreURL).responseJSON { response in
            
            if let json = response.result.value {
                let jsonResponse = JSON(json)
                
                if let resData = jsonResponse["genres"].array {
                    completion(resData)
                }
            }
        }
    }
    
}
