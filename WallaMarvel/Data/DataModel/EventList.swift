//
//  EventSummary.swift
//  WallaMarvel
//
//  Created by Alena's macbook on 03.09.2022.
//

import Foundation

struct EventList: Decodable {
    
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [EventSummary]?
  
}
