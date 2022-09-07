//
//  SearchResultViewController.swift
//  Netlix-CloneApp
//
//  Created by ali dölen on 10.08.2022.
//

import UIKit

protocol SearchResultViewControllerDelegate: AnyObject {
    func searchResultItemTapped(with viewModel: MovieModel )
}

final class SearchResultViewController: UIViewController {
    
    private enum Constants {
        static let collectionHeight: CGFloat = 200
    }
        
    private lazy var searchResultCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: AppConstants.screenWidth / 3 - 10, height: Constants.collectionHeight)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(searchResultCollectionView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultCollectionView.frame = view.bounds
        
    }
    
}

