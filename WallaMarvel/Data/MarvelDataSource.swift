import Foundation


protocol MarvelDataSourceProtocol {
    
    func getHeroes(limit: Int?, offset: Int?, searchString: String?, completionBlock: @escaping (CharacterDataContainer) -> Void)
    func getHeroDetails(heroID: String, completionBlock: @escaping (CharacterDataContainer) -> Void)

}

final class MarvelDataSource: MarvelDataSourceProtocol {
    
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    func getHeroes(limit: Int?, offset: Int?, searchString: String?, completionBlock: @escaping (CharacterDataContainer) -> Void) {
        return apiClient.getHeroes(limit: limit,
                                   offset: offset,
                                   searchString: searchString,
                                   completionBlock: completionBlock)
    }
    
    func getHeroDetails(heroID: String, completionBlock: @escaping (CharacterDataContainer) -> Void) {
        return apiClient.getHeroDetail(heroID: heroID, completionBlock: completionBlock)
    }
    
}
