import Foundation


protocol MarvelDataSourceProtocol {
    
    func getAllHeroes() -> [CharacterDataModel]
    func getHeroesBySearchString() -> [CharacterDataModel]
    func loadNextHeroes(completionBlock: @escaping (Bool) -> Void)
    func getHeroDetails(heroID: String, completionBlock: @escaping (CharacterDataModel?) -> Void)
    func searchHeroes(searchString: String, completionBlock: @escaping (Bool) -> Void)
    func loadNextHeroesByName(completionBlock: @escaping (Bool) -> Void)
    func deleteSearchData()
}

final class MarvelDataSource: MarvelDataSourceProtocol {
    
    private let apiClient: APIClientProtocol
    private var heroesCache: [CharacterDataModel] = [] // simple cache
    private var searchHeroesCache: [CharacterDataModel] = [] // simple cache
    private var isFullArrayDownloaded: Bool = false
    private var isFullSearchArrayDownloaded: Bool = false
    private var searchHeroesByNameString: String? = nil
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    func getAllHeroes() -> [CharacterDataModel] {
        return heroesCache
    }
    
    func getHeroesBySearchString() -> [CharacterDataModel] {
        return searchHeroesCache
    }
    
    func loadNextHeroes(completionBlock: @escaping (Bool) -> Void) {
        
        let offset = heroesCache.count
        return apiClient.getHeroes(offset: offset, completionBlock: { [weak self] result in
            
            switch result {
            case .success(let data):
                var isFullyLoaded = false
                let dataModel = try! JSONDecoder().decode(CharacterDataContainer.self, from: data)
                if let count = dataModel.count, let limit = dataModel.limit {
                    if count < limit {
                        isFullyLoaded = true
                    }
                }
                
                if let heroes = dataModel.characters {
                    self?.heroesCache += heroes
                }
                self?.isFullArrayDownloaded = isFullyLoaded
                completionBlock(isFullyLoaded)
            case .failure(let error):
                // TODO: somethings wrong, should add handler
                print("request failed with error: \(error.debugDescription)")
                completionBlock(true)
            }
        })
    }
    
    func getHeroDetails(heroID: String, completionBlock: @escaping (CharacterDataModel?) -> Void) {
        
        return apiClient.getHeroDetail(heroID: heroID, completionBlock: { result in
            
            switch result {
            case .success(let data):
                let dataModel = try! JSONDecoder().decode(CharacterDataContainer.self, from: data)
                if let characters = dataModel.characters {
                    if characters.count == 1 {
                        completionBlock(characters.first)
                    } else {
                        // TODO: somethings wrong and handler if need
                        completionBlock(characters.first)
                    }
                } else {
                    // TODO: somethings wrong and handler if need
                    completionBlock(nil)
                }
            case .failure(let error):
                // TODO: somethings wrong, should add handler
                print("request failed with error: \(error.debugDescription)")
                completionBlock(nil)
            }
        })
    }
    
    func searchHeroes(searchString: String, completionBlock: @escaping (Bool) -> Void) {
        
        guard let filter = searchHeroesByNameString else {
            deleteSearchData()
            searchHeroesByNameString = searchString
            return loadNextHeroesByName(completionBlock: completionBlock)
        }
        
        if !searchString.elementsEqual(filter) {
            deleteSearchData()
            searchHeroesByNameString = searchString
        }
        
        if isFullSearchArrayDownloaded {
            completionBlock(isFullSearchArrayDownloaded)
            return
        }
        
        return loadNextHeroesByName(completionBlock: completionBlock)
    }

    func loadNextHeroesByName(completionBlock: @escaping (Bool) -> Void) {
        let offset = searchHeroesCache.count
        guard let searchString = searchHeroesByNameString else {
            completionBlock(self.isFullSearchArrayDownloaded)
            return
        }
        
        return apiClient.searchHeroes(offset: offset,
                                      searchString: searchString,
                                      completionBlock: { [weak self] result in
            
            switch result {
            case .success(let data):
                var isFullyLoaded = false
                let dataModel = try! JSONDecoder().decode(CharacterDataContainer.self, from: data)
                if let count = dataModel.count, let limit = dataModel.limit {
                    if count < limit {
                        isFullyLoaded = true
                    }
                }
                
                if let heroes = dataModel.characters {
                    self?.searchHeroesCache += heroes
                }
                
                self?.isFullSearchArrayDownloaded = isFullyLoaded
                completionBlock(isFullyLoaded)
            case .failure(let error):
                // TODO: somethings wrong, should add handler
                print("request failed with error: \(error.debugDescription)")
                completionBlock(false)
            }
        })
    }
    
    func deleteSearchData() {
        searchHeroesCache = []
        searchHeroesByNameString = nil
        isFullSearchArrayDownloaded = false
    }
     
}
