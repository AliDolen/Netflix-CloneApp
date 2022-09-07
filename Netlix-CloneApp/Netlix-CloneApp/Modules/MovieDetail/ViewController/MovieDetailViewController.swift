//
//  MovieDetailViewController.swift
//  Netlix-CloneApp
//
//  Created by ali dölen on 12.08.2022.
//

import UIKit
import WebKit

protocol MovieDetailViewControllerInterface: AnyObject {
    func updateUI(with movieObject: MovieModel, with videoObject: VideoElementsModel)
}

final class MovieDetailViewController: UIViewController {
    
    var viewModel: MovieDetailViewModel?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.text = "Harry Potter"
        return label
    }()
    
    private lazy var overViewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "Best movie to watch"
        return label
    }()
    
    private lazy var downloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureConstraints()
        viewModel?.prepareUI()
    }
    
    private func setupUI() {
        self.view.addSubview(webView)
        self.view.addSubview(titleLabel)
        self.view.addSubview(overViewLabel)
        self.view.addSubview(downloadButton)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 300),
            
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            overViewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            overViewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            overViewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.topAnchor.constraint(equalTo: overViewLabel.bottomAnchor, constant: 25),
            downloadButton.widthAnchor.constraint(equalToConstant: 140),
            downloadButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}

extension MovieDetailViewController: MovieDetailViewControllerInterface {
    func updateUI(with movieObject: MovieModel, with videoObject: VideoElementsModel) {
        titleLabel.text = movieObject.original_title
        overViewLabel.text = movieObject.overview
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(videoObject.id.videoId)") else { return }
        webView.load(URLRequest(url: url))
    }
}

extension MovieDetailViewController {
    static func build(with movieObject: MovieModel, videoObject: VideoElementsModel) -> MovieDetailViewController {
        let movieDetailObject = MovieDetailViewController()
        movieDetailObject.viewModel = MovieDetailViewModel(view: movieDetailObject, movieObject: movieObject, videoObject: videoObject)
        return movieDetailObject
    }
    
}
