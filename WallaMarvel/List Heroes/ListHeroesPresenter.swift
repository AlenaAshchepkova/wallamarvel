import Foundation

protocol ListHeroesPresenterProtocol: AnyObject {
    
    var ui: ListHeroesUI? { get set }
    func screenTitle() -> String
    func loadNextHeroes()
    func getHeroesByName(searchString: String)
    func deleteSearchData()
    func reloadHeroes()
    
}

protocol ListHeroesUI: AnyObject {
    
    func update(heroes: [CharacterDataModel]?)
    
}

final class ListHeroesPresenter: ListHeroesPresenterProtocol {

    var ui: ListHeroesUI?
    private var isLoadingInProgress: Bool = false
    private var isFullyLoadedSearch: Bool = false
    private var isFullyLoadedList: Bool = false
    private let getHeroesUseCase: GetHeroesUseCaseProtocol
    
    init(getHeroesUseCase: GetHeroesUseCaseProtocol = GetHeroes()) {
        self.getHeroesUseCase = getHeroesUseCase
        let heroes = self.getHeroesUseCase.getAllHeroes()
        if heroes.count <= 0 {
            loadNextHeroes()
            
        } else {
            self.ui?.update(heroes: heroes)
        }
    }
    
    func screenTitle() -> String {
        "Heroes"
    }
    
    func reloadHeroes() {
        let heroes = self.getHeroesUseCase.getAllHeroes()
        self.ui?.update(heroes: heroes)
    }
    
    func loadNextHeroes() {
        if !isLoadingInProgress && !isFullyLoadedList {
            isLoadingInProgress = true
            getHeroesUseCase.loadNextHeroes(completionBlock: { [weak self] isFullyLoaded in
                self?.isFullyLoadedList = isFullyLoaded
                self?.isLoadingInProgress = false
                self?.ui?.update(heroes: self?.getHeroesUseCase.getAllHeroes())
            })
        }
    }

    func getHeroesByName(searchString: String) {
        // TODO: change logic for stopping previous request
        if !isLoadingInProgress && !isFullyLoadedSearch {
            isLoadingInProgress = true
            getHeroesUseCase.searchByName(searchString: searchString, completionBlock: { [weak self] isFullyLoaded in
                self?.isFullyLoadedSearch = isFullyLoaded
                self?.isLoadingInProgress = false
                self?.ui?.update(heroes: self?.getHeroesUseCase.getHeroesBySearchString())
            })
        }
    }
    
    func deleteSearchData() {
        isFullyLoadedSearch = false
        getHeroesUseCase.deleteSearchData()
    }
    
}

