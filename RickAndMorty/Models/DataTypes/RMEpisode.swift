//
//  RMEpisode.swift
//  RickAndMorty
//
//  Created by Sevar Jafarli on 30.04.23.
//

import Foundation

struct RMEpisode: Codable, RMEpisodeDataRenderer {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}
