//
//  DownloadsViewController.swift
//  Netlix-CloneApp
//
//  Created by ali dölen on 2.08.2022.
//

import UIKit

final class DownloadsViewController: UIViewController {

    private lazy var downloadTable: UITableView = {
       let tableView = UITableView()
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupView()
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        title = "Downloads"
        view.addSubview(downloadTable)
    }
    
    func getDownloadedMoviesFromLocalStorage() {
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        downloadTable.frame = view.bounds
    }

}
