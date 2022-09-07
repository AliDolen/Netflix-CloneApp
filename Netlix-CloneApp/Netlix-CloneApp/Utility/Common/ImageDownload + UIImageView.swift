//
//  ImageDownload+UIImageView.swift
//  Netlix-CloneApp
//
//  Created by ali dölen on 9.08.2022.
//

import Foundation
import UIKit

extension UIImageView {
    func downloadImageWithUrl(imageUrl: String) {
        self.image = nil
        if let cachedImage = AppConstants.imageCache.object(forKey: NSString(string: imageUrl)) {
            self.runOnMainThread { [weak self] in
                self?.image = cachedImage
                Logger.log(.success, "image is catched from cache \(imageUrl)")
                return
            }
        } else {
            let blockOperation = BlockOperation()
            blockOperation.addExecutionBlock({ [weak self] in
                guard let url = URL(string: imageUrl) else {
                    self?.runOnMainThread {
                        self?.image = AppConstants.placeHolderImage
                        Logger.log(.error, "Image URL is wrong")
                    }
                    return
                }
                do {
                    let data = try Data(contentsOf: url)
                    let newImage = UIImage(data: data)
                    if let newImage = newImage {
                        AppConstants.imageCache.setObject(newImage, forKey: NSString(string: imageUrl))
                        self?.runOnMainThread {
                            self?.image = newImage
                        }
                        
                    } else {
                        self?.runOnMainThread {
                            self?.image = AppConstants.placeHolderImage
                            Logger.log(.error, "Image could not be shown")
                        }
                    }
                } catch {
                    self?.runOnMainThread {
                        self?.image = AppConstants.placeHolderImage
                        Logger.log(.error, "Image could not be shown")
                    }
                }
            })
            AppConstants.imageQueue.addOperation(blockOperation)
            blockOperation.completionBlock = {
                Logger.log(.success, "Image downloaded \(imageUrl)")
            }
        }
    }
    fileprivate func runOnMainThread(block: @escaping () -> Void) {
        if Thread.isMainThread {
            block()
        } else {
            let mainQueue = OperationQueue.main
            mainQueue.addOperation({
                block()
            })
        }
    }
    
}
