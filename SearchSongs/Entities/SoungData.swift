//
//  SoungData.swift
//
//  Created by Vasiliy Vygnych on 04.10.2023.
//

import Foundation

struct SongData: Codable {
    let resultCount: Int
    let results: [Results]
}

struct Results: Codable {
    let artistName: String
    let trackName: String
    let artworkUrl30, artworkUrl60, artworkUrl100: String?

}

enum CodingKeys: String, CodingKey {
    case artistName, trackName
    case artworkUrl30, artworkUrl60, artworkUrl100
}
