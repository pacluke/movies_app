//
//  ViewController.swift
//  Movies
//
//  Created by Lucas Flores on 18/03/19.
//  Copyright © 2019 lucas.flores. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        Service().requestUpcomingMovies { response in
////            print(response)
//        }
        
//        Service().requestMoviesGenre { response in
//            print(response)
//        }
        
        let moviesController = MoviesController()
        moviesController.getMoviesData { response in
            for movie in response {
                print(movie.description())
            }
        }
    }


}

