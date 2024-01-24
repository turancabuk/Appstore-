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
    var trackId: Int?
    var trackName: String?
    let primaryGenreName: String
    let averageUserRating: Float?
    let artworkUrl100: String
    var screenshotUrls: [String]?
    var description: String?
    let releaseNotes: String?
    let formattedPrice: String?
    var artistName: String?
    var collectionName: String?
}
