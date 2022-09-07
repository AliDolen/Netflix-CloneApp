//
//  TitleCollectionViewCell.swift
//  Netlix-CloneApp
//
//  Created by ali dölen on 11.08.2022.
//

import Foundation
import UIKit

protocol MovieCollectionCellInterface: AnyObject {
    func updateUI(with movieObject: MovieModel)
}

class TitleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TitleCollectionViewCell"
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var viewModel: MovieCellViewModel? {
        didSet {
            viewModel?.prepareUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
}

extension TitleCollectionViewCell: MovieCollectionCellInterface {
    func updateUI(with movieObject: MovieModel) {
        guard let movieUrlPath = movieObject.poster_path else { return }
        let url = "https://image.tmdb.org/t/p/w500\(movieUrlPath)"
        DispatchQueue.main.async { [weak self] in
            self?.posterImageView.downloadImageWithUrl(imageUrl: url)
        }
    }
    
}
