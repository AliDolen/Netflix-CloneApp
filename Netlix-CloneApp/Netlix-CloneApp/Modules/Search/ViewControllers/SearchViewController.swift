//
//  SearchViewController.swift
//  Netlix-CloneApp
//
//  Created by ali dölen on 4.08.2022.
//

import UIKit

protocol SearchResultInterface: AnyObject {
    func getMoviesFetched()
}

final class SearchViewController: UIViewController {
    
    lazy var viewModel: SearchViewModelProtocol = SearchViewModel(networkService: NetworkService(networkRequest: NetworkManager(), environment: .development), view: self)
    
    private lazy var discoverTable: UITableView = {
       var tableView = UITableView()
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var searchController: UISearchController = {
        var controller = UISearchController(searchResultsController: SearchResultViewController())
        controller.searchBar.placeholder = "Search for a movie"
        controller.searchBar.searchBarStyle = .minimal
        controller.searchResultsUpdater = self
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupUI()
        viewModel.getDiscoverMovies()
        viewModel.getSearchResult()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTable.frame = view.bounds
    }
    
    private func setupNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationItem.searchController = searchController
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(discoverTable)
        title = "Search"
    }
}

extension SearchViewController: SearchResultInterface {
    func getMoviesFetched() {
        DispatchQueue.main.async { [weak self] in
            self?.discoverTable.reloadData()
        }
    }
}
