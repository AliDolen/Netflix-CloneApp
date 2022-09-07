//
//  DownloadsViewControllers+UITableView.swift
//  Netlix-CloneApp
//
//  Created by ali dölen on 11.08.2022.
//

import Foundation
import UIKit

extension DownloadsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension DownloadsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? UITableViewCell else { return UITableViewCell() }
        return cell
    }
    
}
