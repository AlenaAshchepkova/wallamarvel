//
//  DetailHeroPresenterProtocol.swift
//  WallaMarvel
//
//  Created by Alena's macbook on 01.09.2022.
//

import Foundation

protocol DetailsHeroPresenterProtocol: AnyObject {
    
    var ui: DetailsHeroUI? { get set }
    
    func getHeroDetails(heroID: String)
    
}

protocol DetailsHeroUI: AnyObject {
    
    func update(hero: CharacterDataModel)
    
}

final class DetailsHeroPresenter: DetailsHeroPresenterProtocol {

    var ui: DetailsHeroUI?
    private let getHeroesUseCase: GetHeroesUseCaseProtocol
    
    init(getHeroesUseCase: GetHeroesUseCaseProtocol = GetHeroes()) {
        self.getHeroesUseCase = getHeroesUseCase
    }
    
    func getHeroDetails(heroID: String) {
        getHeroesUseCase.loadDetails(heroID: heroID, completionBlock: { characterDataModel in
            
            guard let model = characterDataModel else {
                return
            }
            self.ui?.update(hero: model)
        })
    }
    
}

