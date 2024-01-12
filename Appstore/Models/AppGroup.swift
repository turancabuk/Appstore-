//
//  AppGroup.swift
//  Appstore
//
//  Created by Turan Çabuk on 8.01.2024.
//

import Foundation

struct AppGroup: Decodable {
    
    let feed: Feed
}

struct Feed: Decodable {
    
    let title: String
    let results: [FeedResult]
}

struct FeedResult: Decodable {
    
    let name, id, artistName, artworkUrl100: String
}
