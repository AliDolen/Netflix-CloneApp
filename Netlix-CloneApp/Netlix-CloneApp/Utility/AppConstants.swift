//
//  AppConstants.swift
//  Netlix-CloneApp
//
//  Created by ali dölen on 9.08.2022.
//

import Foundation
import UIKit


struct AppConstants {
    
    static let screenHeight = UIScreen.main.bounds.height
    static let screenWidth = UIScreen.main.bounds.width
    
    static let alertDuration = 1.0
    
    static let https = "https//:"
    static let thumbnail = "_2.jpg"
    static let bigImage = "_27.jpg"
    
    static let imageQueue = OperationQueue()
    static let imageCache = NSCache<NSString, UIImage>()
    static let placeHolderImage = UIImage(systemName: "xmark.octagon.fill")
    
}
