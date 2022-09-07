//
//  Router.swift
//  Netlix-CloneApp
//
//  Created by ali dölen on 4.08.2022.
//

import Foundation
import UIKit

final class Router {
    
    enum Screens {
        case home
        case upcoming
        case search
        case downloads
        case movieDetail(movieobject: MovieModel, videoObject: VideoElementsModel)
        
        func setViewController() -> UIViewController {
            switch self {
            case .home:
                return HomeViewController()
            case .upcoming:
                return UpComingMovieViewController()
            case .search:
                return SearchViewController()
            case .downloads:
                return DownloadsViewController()
            case .movieDetail(let movieObject, let videoObject):
                return MovieDetailViewController.build(with: movieObject, videoObject: videoObject)
            }
        }
    }
    
    class func navigate(to page: Screens) {
        let currentController = Router.findCurrentController()
        currentController?.navigationController?.pushViewController(page.setViewController(), animated: true)
    }
    
    class func findCurrentController(screen: Screens? = nil, baseVC: UIViewController? = nil) -> UIViewController? {
        if screen != nil {
            return screen?.setViewController()
        }
        let baseViewController = baseVC ?? UIApplication.shared.windows.filter { $0.isKeyWindow}.first?.rootViewController
        
        if let tab = baseViewController as? UITabBarController,
           let selectedVC = tab.selectedViewController {
            return findCurrentController(baseVC: selectedVC)
        } else if let nav = baseViewController as? UINavigationController {
            return findCurrentController(baseVC: nav.visibleViewController)
        }
        return baseViewController
    }
    
}

