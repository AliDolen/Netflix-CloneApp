//
//  HomeViewController.swift
//  Netlix-CloneApp
//
//  Created by ali dölen on 8.08.2022.
//

import UIKit

protocol MovieListViewInterface: AnyObject {
    func movieListFetched()
}

final class HomeViewController: BaseViewController {
    
    private var headerView: MovieHeaderView?
    private var randomTrendMovie: MovieModel?
    
    enum Sections: Int {
        case TrendingMovies = 0
        case TrendingTV = 1
        case Popular = 2
        case Upcoming = 3
        case TopRated = 4
    }
    
    lazy var viewModel: HomeViewModelProtocol = HomeViewModel(view: self,
                                                              networkService: NetworkService(networkRequest: NetworkManager(),
                                                                                             environment: .development))
    
    let sectionTitles = ["Trending Movies", "Trending TV", "Popular", "Upcoming Movies", "Top Rated"]
    
    private lazy var homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureUI()
        viewModel.getTrendingMovies()
        viewModel.getTrendingTvs()
        viewModel.getTopRated()
        viewModel.getPopularMovies()
        viewModel.getUpcomingMovies()
        headerView = MovieHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTable.tableHeaderView = headerView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
    private func configureHeaderView() {
        let randomMovie = viewModel.trendingMovies?.randomElement()
        guard let selectedMovies = randomMovie else { return }
        headerView?.configureUI(with: selectedMovies)
    }
    
    private func configureNavBar() {
        var image = UIImage(named: Assets.netflixLogo)
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        let personIcon = UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil)
        let playIcon = UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItems = [personIcon, playIcon]
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
    }
}

extension HomeViewController: MovieListViewInterface {
    func movieListFetched() {
        configureHeaderView()
        DispatchQueue.main.async { [weak self] in
            self?.homeFeedTable.reloadData()
        }
    }
}



