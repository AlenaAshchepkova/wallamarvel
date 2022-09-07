import Foundation


protocol MarvelRepositoryProtocol {
    
    func getAllHeroes() -> [CharacterDataModel]
    func getHeroesBySearchString() -> [CharacterDataModel]
    func loadNextHeroes(completionBlock: @escaping (Bool) -> Void)
    func getHeroDetails(heroID: String, completionBlock: @escaping (CharacterDataModel?) -> Void)
    func searchHeroes(searchString: String, completionBlock: @escaping (Bool) -> Void)
    func deleteSearchData()
}

final class MarvelRepository: MarvelRepositoryProtocol {
    
    private let dataSource: MarvelDataSourceProtocol
    
    init(dataSource: MarvelDataSourceProtocol = MarvelDataSource()) {
        self.dataSource = dataSource
    }
    
    func getAllHeroes() -> [CharacterDataModel] {
        return dataSource.getAllHeroes()
    }
    
    func getHeroesBySearchString() -> [CharacterDataModel] {
        return dataSource.getHeroesBySearchString()
    }
    
    func loadNextHeroes(completionBlock: @escaping (Bool) -> Void) {
        dataSource.loadNextHeroes(completionBlock: completionBlock)
    }
    
    func getHeroDetails(heroID: String, completionBlock: @escaping (CharacterDataModel?) -> Void) {
        dataSource.getHeroDetails(heroID: heroID, completionBlock: completionBlock)
    }
    
    func searchHeroes(searchString: String, completionBlock: @escaping (Bool) -> Void) {
        dataSource.searchHeroes(searchString: searchString, completionBlock: completionBlock)
    }
    
    func deleteSearchData() {
        dataSource.deleteSearchData()
    }
    
}
