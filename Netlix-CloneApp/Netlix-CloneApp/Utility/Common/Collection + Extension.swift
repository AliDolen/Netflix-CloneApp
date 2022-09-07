//
//  Collection + Extension.swift
//  Netlix-CloneApp
//
//  Created by ali dölen on 11.08.2022.
//

import Foundation

extension Collection {
    
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safeIndex index: Index) -> Element? {
         indices.contains(index) ? self[index] : nil
    }
}
