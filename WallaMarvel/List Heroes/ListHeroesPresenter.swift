import Foundation

protocol ListHeroesPresenterProtocol: AnyObject {
    
    var ui: ListHeroesUI? { get set }
    func screenTitle() -> String
    func getNextHeroes()
    func getHeroesByName(searchString: String?)
    
}

protocol ListHeroesUI: AnyObject {
    
    func update(heroes: [CharacterDataModel]?, shouldDeletePrevious: Bool)
    
}

final class ListHeroesPresenter: ListHeroesPresenterProtocol {
 
    enum Constant {
        static let limit: Int = 30
    }
    
    var ui: ListHeroesUI?
    private var limit: Int = Constant.limit
    private var offset: Int = 0
    private var isLoadingInProgress: Bool = false
    
    private let getHeroesUseCase: GetHeroesUseCaseProtocol
    
    init(getHeroesUseCase: GetHeroesUseCaseProtocol = GetHeroes()) {
        self.getHeroesUseCase = getHeroesUseCase
    }
    
    func screenTitle() -> String {
        "Heroes"
    }
    
    func getNextHeroes() {
        if !isLoadingInProgress {
            isLoadingInProgress = true
            getHeroesUseCase.execute(limit: limit, offset: offset, searchString: nil, completionBlock: { characterDataContainer in
                self.offset += self.limit
                self.isLoadingInProgress = false
                self.ui?.update(heroes: characterDataContainer.characters, shouldDeletePrevious: false)
            })
        }
    }
    
    func getHeroesByName(searchString: String?) {
        if !isLoadingInProgress {
            isLoadingInProgress = true
            getHeroesUseCase.execute(limit: nil, offset: nil, searchString: searchString,
                                     completionBlock: { characterDataContainer in
                self.isLoadingInProgress = false
                self.ui?.update(heroes: characterDataContainer.characters, shouldDeletePrevious: true)
            })
        }
    }
    
}

