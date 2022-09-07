//
//  String+Extension.swift
//  Netlix-CloneApp
//
//  Created by ali dölen on 8.08.2022.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
