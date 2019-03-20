//
//  MovieInfoTableViewController.swift
//  Movies
//
//  Created by Lucas Flores on 20/03/19.
//  Copyright © 2019 lucas.flores. All rights reserved.
//

import UIKit
import Kingfisher

class MovieInfoTableViewController: UITableViewController {
    
    @IBOutlet weak var movieView: UIView!
    @IBOutlet weak var movieBackdrop: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieGenres: UILabel!
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.title = "Movie info"
        
        self.movieBackdrop.kf.setImage(with: movie.backdrop)
        self.movieTitle.text = movie.title
        self.movieReleaseDate.text = movie.releaseDate
        self.movieGenres.text = movie.genres
        self.movieView.layer.backgroundColor = UIColor(red:0.27, green:0.31, blue:0.55, alpha:1.0).cgColor
        self.movieView.layer.cornerRadius = 5
        self.movieView.layer.masksToBounds = false
        self.movieView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.movieView.layer.shadowOpacity = 0.5
        
        self.movieBackdrop.layer.cornerRadius = 5
        self.movieBackdrop.layer.masksToBounds = false
        self.movieBackdrop.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.movieBackdrop.layer.shadowOpacity = 0.5
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(red:0.43, green:0.55, blue:0.63, alpha:1.0)
        self.tableView.backgroundColor = UIColor(red:0.43, green:0.55, blue:0.63, alpha:1.0)
        self.view.backgroundColor = UIColor(red:0.43, green:0.55, blue:0.63, alpha:1.0)
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.43, green:0.55, blue:0.63, alpha:1.0)
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.black], for: .normal)
        
        self.tableView.rowHeight = UITableView.automaticDimension;
        self.tableView.estimatedRowHeight = 200.0;
        
        let shareButton =  UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(showShareOptions))
        self.navigationItem.rightBarButtonItem = shareButton
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieOverview", for: indexPath) as! MovieOverviewTableViewCell
        
        cell.movieOverviewLabel.text = movie.overview
        cell.selectionStyle = UITableViewCell.SelectionStyle.none

        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    private func shareText() {
        let pokemonDescription = self.movie.description()
        let textToShare = [ pokemonDescription ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    private func shareCard() {
        var image = UIImage();
        UIGraphicsBeginImageContextWithOptions(self.tableView.contentSize, false, UIScreen.main.scale)
        
        // save initial values
        let savedContentOffset = self.tableView.contentOffset;
        let savedFrame = self.tableView.frame;
        let savedBackgroundColor = self.tableView.backgroundColor
        
        // reset offset to top left point
        self.tableView.contentOffset = CGPoint(x: 0, y: 0);
        // set frame to content size
        self.tableView.frame = CGRect(x: 0, y: 0, width: self.tableView.contentSize.width, height: self.tableView.contentSize.height);
        // remove background
        self.tableView.backgroundColor = UIColor.clear
        
        // make temp view with scroll view content size
        // a workaround for issue when image on ipad was drawn incorrectly
        let tempView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.contentSize.width, height: self.tableView.contentSize.height));
        
        // save superview
        let tempSuperView = self.tableView.superview
        // remove scrollView from old superview
        self.tableView.removeFromSuperview()
        // and add to tempView
        tempView.addSubview(self.tableView)
        
        // render view
        // drawViewHierarchyInRect not working correctly
        tempView.layer.render(in: UIGraphicsGetCurrentContext()!)
        // and get image
        image = UIGraphicsGetImageFromCurrentImageContext()!;
        
        // and return everything back
        tempView.subviews[0].removeFromSuperview()
        tempSuperView?.addSubview(self.tableView)
        
        // restore saved settings
        self.tableView.contentOffset = savedContentOffset;
        self.tableView.frame = savedFrame;
        self.tableView.backgroundColor = savedBackgroundColor
        
        UIGraphicsEndImageContext();
        
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    @objc private func showShareOptions() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let shareText = UIAlertAction(title: "Share movie text", style: .default) { (action) in
            self.shareText()
        }
        let shareCard = UIAlertAction(title: "Share movie card", style: .default) { (action) in
            self.shareCard()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        actionSheet.addAction(shareText)
        actionSheet.addAction(shareCard)
        actionSheet.addAction(cancelAction)
        self.present(actionSheet, animated: true, completion: nil)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
