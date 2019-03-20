//
//  MovieTableViewCell.swift
//  Movies
//
//  Created by Lucas Flores on 20/03/19.
//  Copyright © 2019 lucas.flores. All rights reserved.
//

import UIKit

class MovieOverviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieOverview: UIView!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.movieOverview.layer.backgroundColor = UIColor(red:0.27, green:0.31, blue:0.55, alpha:1.0).cgColor
        self.movieOverview.layer.cornerRadius = 5
        self.movieOverview.layer.masksToBounds = false
        self.movieOverview.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.movieOverview.layer.shadowOpacity = 0.5
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
