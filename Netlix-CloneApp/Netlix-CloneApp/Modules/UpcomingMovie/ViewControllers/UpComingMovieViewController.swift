//
//  UpComingMovieViewController.swift
//  Netlix-CloneApp
//
//  Created by ali dölen on 4.08.2022.
//

import UIKit

protocol UpcomingMoviesFetched: AnyObject {
    func upcomingMoviesFetched()
}

final class UpComingMovieViewController: UIViewController {
    private lazy var upcomingTable: UITableView = {
       let tableView = UITableView()
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
   lazy var viewModel: UpcomingMovieViewModelProtocol = UpcomingMovieViewModel(view: self, networkService: NetworkService(networkRequest: NetworkManager(), environment: .development))

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavBar()
        viewModel.getUpcomingMovies()
    }
    
    private func configureUI() {
        view.addSubview(upcomingTable)
        view.backgroundColor = .systemBackground
        title = "Upcoming"
    }
  
    private func configureNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingTable.frame = view.bounds
    }
}

extension UpComingMovieViewController: UpcomingMoviesFetched {
    func upcomingMoviesFetched() {
        DispatchQueue.main.async { [weak self] in
            self?.upcomingTable.reloadData()
        }
    }
}
