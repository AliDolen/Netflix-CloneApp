//
//  SearchViewController  + UISearchResultUpdating.swift
//  Netlix-CloneApp
//
//  Created by ali dölen on 11.08.2022.
//

import Foundation
import UIKit

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultController = searchController.searchResultsController as? SearchResultViewController else { return }
        viewModel.querry = query
    }
    
}
