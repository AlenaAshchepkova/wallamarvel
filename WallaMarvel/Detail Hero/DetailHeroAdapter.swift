//
//  DetailHeroProvider.swift
//  WallaMarvel
//
//  Created by Alena's macbook on 01.09.2022.
//

import Foundation
import UIKit

final class DetailHeroAdapter: NSObject {
    
    var hero: CharacterDataModel? {
        didSet {
            DispatchQueue.main.async {
                self.view.configure(model: self.hero)
                self.view.reloadInputViews()
            }
        }
    }
    
    var url: URL? {
        guard let urlString = hero?.urls?.first?.url else {
            return nil
        }
        return URL(string: urlString)
    }
    
    private let view: DetailHeroView
    
    init(hero: CharacterDataModel?, view: DetailHeroView) {
        self.hero = hero
        self.view = view
        
        super.init()
        
    }
    
}
