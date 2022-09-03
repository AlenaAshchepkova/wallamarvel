//
//  StoryList.swift
//  WallaMarvel
//
//  Created by Alena's macbook on 03.09.2022.
//

import Foundation

struct StoryList: Decodable {
    
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [StorySummary]?

}
