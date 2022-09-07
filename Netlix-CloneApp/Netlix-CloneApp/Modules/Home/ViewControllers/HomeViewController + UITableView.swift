//
//  HomeViewController+TableViewDelegate.swift
//  Netlix-CloneApp
//
//  Created by ali dölen on 8.08.2022.
//

import Foundation
import UIKit

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else { return UITableViewCell() }
        
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            cell.configure(with: viewModel.trendingMovies ?? [])
        case Sections.TrendingTV.rawValue:
            cell.configure(with: viewModel.trendingTvs ?? [])
        case Sections.TopRated.rawValue:
            cell.configure(with: viewModel.topRatedMovies ?? [])
        case Sections.Popular.rawValue:
            cell.configure(with: viewModel.popularMovies ?? [])
        case Sections.Upcoming.rawValue:
            cell.configure(with: viewModel.upcomingMovies ?? [])
        default:
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HomeViewConstants.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return HomeViewConstants.heightForHeader
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HomeViewConstants.numbersOfRow
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: HomeViewConstants.headerWidth, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
}

extension HomeViewController {
    struct HomeViewConstants {
        static let rowHeight: CGFloat = 200
        static let heightForHeader: CGFloat = 40
        static let numbersOfRow: Int = 1
        static let headerWidth: CGFloat = 100
    }
}
