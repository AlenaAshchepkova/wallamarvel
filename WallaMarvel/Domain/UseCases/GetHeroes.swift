import Foundation


protocol GetHeroesUseCaseProtocol {
    
    func getAllHeroes() -> [CharacterDataModel]
    func getHeroesBySearchString() -> [CharacterDataModel]
    func loadNextHeroes(completionBlock: @escaping (Bool) -> Void)
    func loadDetails(heroID: String, completionBlock: @escaping (CharacterDataModel?) -> Void)
    func searchByName(searchString: String, completionBlock: @escaping (Bool) -> Void)
    func deleteSearchData()
}

struct GetHeroes: GetHeroesUseCaseProtocol {
    private let repository: MarvelRepositoryProtocol
    
    init(repository: MarvelRepositoryProtocol = MarvelRepository()) {
        self.repository = repository
    }
    
    func getAllHeroes() -> [CharacterDataModel] {
        return repository.getAllHeroes()
    }
    
    func getHeroesBySearchString() -> [CharacterDataModel] {
        return repository.getHeroesBySearchString()
    }
    
    func loadNextHeroes(completionBlock: @escaping (Bool) -> Void) {
        repository.loadNextHeroes(completionBlock: completionBlock)
    }
    
    func loadDetails(heroID: String, completionBlock: @escaping (CharacterDataModel?) -> Void) {
        repository.getHeroDetails(heroID: heroID, completionBlock: completionBlock)
    }

    func searchByName(searchString: String, completionBlock: @escaping (Bool) -> Void) {
        repository.searchHeroes(searchString: searchString, completionBlock: completionBlock)
    }
    
    func deleteSearchData() {
        repository.deleteSearchData()
    }
    
}
