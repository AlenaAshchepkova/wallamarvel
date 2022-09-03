//
//  SeriesList.swift
//  WallaMarvel
//
//  Created by Alena's macbook on 02.09.2022.
//

import Foundation

struct SeriesList: Decodable {
    
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [SeriesSummary]?
    
}
