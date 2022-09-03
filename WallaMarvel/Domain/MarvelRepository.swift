import Foundation


protocol MarvelRepositoryProtocol {
    
    func getHeroes(limit: Int?, offset: Int?, searchString: String?,
                   completionBlock: @escaping (CharacterDataContainer) -> Void)
    
    func getHeroDetails(heroID: String, completionBlock: @escaping (CharacterDataContainer) -> Void)
    
}

final class MarvelRepository: MarvelRepositoryProtocol {
    
    private let dataSource: MarvelDataSourceProtocol
    
    init(dataSource: MarvelDataSourceProtocol = MarvelDataSource()) {
        self.dataSource = dataSource
    }
    
    func getHeroes(limit: Int?, offset: Int?, searchString: String?, completionBlock: @escaping (CharacterDataContainer) -> Void) {
        
        dataSource.getHeroes(limit: limit, offset: offset, searchString: searchString,
                             completionBlock: completionBlock)
    }
    
    func getHeroDetails(heroID: String, completionBlock: @escaping (CharacterDataContainer) -> Void) {
        dataSource.getHeroDetails(heroID: heroID, completionBlock: completionBlock)
    }
    
}
