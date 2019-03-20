//
//  MoviesTableViewController.swift
//  Movies
//
//  Created by Lucas Flores on 19/03/19.
//  Copyright © 2019 lucas.flores. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftOverlays

extension MoviesTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

class MoviesTableViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    private var moviesData: [Movie] = [Movie]()
    private let moviesControler: MoviesController = MoviesController()
    private var filteredMovies:[Movie] = [Movie]()
    
    private var totalPages: Int = 0
    private var loadedPages: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.title = "Movies"
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(red:0.43, green:0.55, blue:0.63, alpha:1.0)
        self.tableView.backgroundColor = UIColor(red:0.43, green:0.55, blue:0.63, alpha:1.0)
        self.view.layer.backgroundColor = UIColor(red:0.43, green:0.55, blue:0.63, alpha:1.0).cgColor
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.43, green:0.55, blue:0.63, alpha:1.0)
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.black], for: .normal)

        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search upcoming movies..."
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        self.showWaitOverlay()
        self.moviesControler.getMoviesData { (movies, totalPages) in
            self.moviesData = movies
            self.totalPages = totalPages
            self.tableView.reloadData()
            self.removeAllOverlays()
        }
        
    }
    
    
    // MARK: - Search view
    
    private func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredMovies = moviesData.filter({( title : Movie) -> Bool in
            return title.title.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    private func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if isFiltering() {
            return filteredMovies.count
        }
        return moviesData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movie", for: indexPath) as! MovieTableViewCell
        
        var movie: Movie
        
        if isFiltering() {
            movie = self.filteredMovies[indexPath.row]
        } else {
            movie = self.moviesData[indexPath.row]
        }

        cell.movieTitle.text = movie.title
        cell.movieGenres.text = movie.genres
        cell.movieReleaseDate.text = movie.releaseDate
        cell.moviePoster.kf.setImage(with: movie.poster)
        cell.selectionStyle = UITableViewCell.SelectionStyle.none

        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = moviesData.count - 1
        if indexPath.row == lastElement && self.loadedPages < self.totalPages{
            self.showWaitOverlay()
            self.loadedPages += 1
            self.moviesControler.getMoviesData(page: self.loadedPages) { (movies, totalPerPage) in
                self.moviesData.append(contentsOf: movies)
                self.tableView.reloadData()
                self.removeAllOverlays()
            }
        }
        cell.backgroundColor = UIColor.clear
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let selectedRow = self.tableView.indexPathForSelectedRow!.row
        let movie: Movie
        
        if isFiltering() {
            movie = self.filteredMovies[selectedRow]
        } else {
            movie = self.moviesData[selectedRow]
        }
        
        if segue.identifier == "selectedMovie" {
            let movieView = segue.destination as! MovieInfoTableViewController
            movieView.movie = movie
        }
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
