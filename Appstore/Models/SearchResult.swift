//
//  SearchResult.swift
//  Appstore
//
//  Created by Turan Çabuk on 4.01.2024.
//

import Foundation

struct SearchResult: Decodable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Decodable {
    let trackName: String
    let primaryGenreName: String
    let averageUserRating: Float
    let artworkUrl100: String
    let screenshotUrls: [String]
}
