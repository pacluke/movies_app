//
//  MovieViewController.swift
//  Movies
//
//  Created by Lucas Flores on 20/03/19.
//  Copyright © 2019 lucas.flores. All rights reserved.
//

import UIKit
import Kingfisher

class MovieViewController: UIViewController {
    
    var movie: Movie!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieGenres: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Movie info"
        
        self.movieTitle.text = movie.title
        self.movieReleaseDate.text = movie.releaseDate
        self.movieGenres.text = movie.genres
        self.movieOverview.text = movie.overview
        self.moviePoster.kf.setImage(with: movie.poster)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
