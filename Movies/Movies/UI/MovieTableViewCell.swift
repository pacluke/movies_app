//
//  MovieTableViewCell.swift
//  Movies
//
//  Created by Lucas Flores on 20/03/19.
//  Copyright © 2019 lucas.flores. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieView: UIView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieGenres: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.movieView.layer.backgroundColor = UIColor(red:0.27, green:0.31, blue:0.55, alpha:1.0).cgColor
        
        self.movieView.layer.cornerRadius = 5
        self.movieView.layer.masksToBounds = false
        self.movieView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.movieView.layer.shadowOpacity = 0.5
        
        self.moviePoster.layer.cornerRadius = 5
        self.moviePoster.layer.masksToBounds = false
        self.moviePoster.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.moviePoster.layer.shadowOpacity = 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
