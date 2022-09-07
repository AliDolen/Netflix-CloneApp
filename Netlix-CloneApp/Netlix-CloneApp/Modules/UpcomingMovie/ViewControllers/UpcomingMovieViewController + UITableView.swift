//
//  UpcomingMovieViewController+UITableView.swift
//  Netlix-CloneApp
//
//  Created by ali dölen on 9.08.2022.
//

import Foundation
import UIKit

extension UpComingMovieViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension UpComingMovieViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfUpcomingMovie()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        guard let title = viewModel.getUpcomingMovieObject(row: indexPath.row) else { return UITableViewCell() }
        cell.configureUI(with: title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.height
    }
    
}

extension UpComingMovieViewController {
    enum Constants {
        static let height: CGFloat = 150
    }
}
