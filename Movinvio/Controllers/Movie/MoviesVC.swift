//
//  MoviesVC.swift
//  Movinvio
//
//  Created by Ezgi Üstünel on 4.06.2022.
//

import UIKit

final class MoviesVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var movieVMs: [MovieVM] = []
    private var searchedMovies: [MovieVM] = []
    private var isSearching = false
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var activeMovies: [MovieVM] {
        return isSearching == true ? searchedMovies : movieVMs
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    // MARK: - Setup
    private func setupUI() {
        tableView.register(UINib(nibName: "MovieTVC", bundle: nil), forCellReuseIdentifier: "MovieTVC")
        
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = UIColor.systemOrange
        navigationItem.searchController = searchController
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.systemOrange]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    // MARK: - Load Data
    private func loadData() {
        movieVMs.removeAll()
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        
        API.getMovies { result in
            switch result {
            case .success(let response):
                self.movieVMs.append(MovieVM(movie: response))
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            case .failure(let error):
                print(error.localizedDescription)
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
        }
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MovieDetailVC" {
            guard let movie = sender as? MovieVM else { return }
            let movieDetailVC = segue.destination as! MovieDetailVC
            movieDetailVC.movie = movie
        }
    }
}

extension MoviesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movieVMs[indexPath.row]
        performSegue(withIdentifier: "MovieDetailVC", sender: movie)
    }
}

extension MoviesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activeMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTVC", for: indexPath) as! MovieTVC
        cell.setData(activeMovies[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}

extension MoviesVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.searchTextField.textColor = UIColor.white
        
        if searchText == "" {
            isSearching = false
        } else {
            isSearching = true
            searchedMovies = searchText.isEmpty ? movieVMs : movieVMs.filter {
                $0.searchText.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}
