import Foundation


protocol GetHeroesUseCaseProtocol {
    
    func execute(limit: Int?, offset: Int?, searchString: String?, completionBlock: @escaping (CharacterDataContainer) -> Void)
    func loadDetails(heroID: String, completionBlock: @escaping (CharacterDataContainer) -> Void)
    
}

struct GetHeroes: GetHeroesUseCaseProtocol {
    private let repository: MarvelRepositoryProtocol
    
    init(repository: MarvelRepositoryProtocol = MarvelRepository()) {
        self.repository = repository
    }
    
    func execute(limit: Int?, offset: Int?, searchString: String?, completionBlock: @escaping (CharacterDataContainer) -> Void) {
        
        repository.getHeroes(limit: limit, offset: offset, searchString: searchString, completionBlock: completionBlock)
    }
    
    func loadDetails(heroID: String, completionBlock: @escaping (CharacterDataContainer) -> Void) {
        repository.getHeroDetails(heroID: heroID, completionBlock: completionBlock)
    }

}
