//
//  CharacterDetailInformation.swift
//  WallaMarvel
//
//  Created by Alena's macbook on 01.09.2022.
//

import Foundation

struct CharacterDetailInformation: Decodable {
    
    let id: Int
    let name: String
    let description: String
    let modified: Date
    let resourceURI: String
    let urls: [Url]
    let thumbnail: Thumbnail
    let comics: ComicsList
    let stories: StoryList
    let events: EventList
    let series: SeriesList
    
}
