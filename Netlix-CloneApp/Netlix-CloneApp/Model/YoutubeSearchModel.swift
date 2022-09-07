//
//  YoutubeSearchModel.swift
//  Netlix-CloneApp
//
//  Created by ali dölen on 12.08.2022.
//

import Foundation

struct VideoElementsModel: Codable {
    let id: VideoIdModel
    
    enum CodingKeys: String, CodingKey {
        case id
    }
}

struct VideoIdModel: Codable {
    let kind: String
    let videoId: String
    
    enum CodingKeys: String, CodingKey {
        case kind
        case videoId
    }
}
