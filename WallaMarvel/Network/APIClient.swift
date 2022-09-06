import Foundation

protocol APIClientProtocol {
    
    func getHeroes(limit: Int?, offset: Int?, searchString: String?, completionBlock: @escaping (CharacterDataContainer) -> Void)
    func getHeroDetail(heroID: String, completionBlock: @escaping (CharacterDataContainer) -> Void)
    
}

final class APIClient: APIClientProtocol {

    enum KeysConstants {
        static let privateKey = "188f9a5aa76846d907c41cbea6506e4cc455293f"
        static let publicKey = "d575c26d5c746f623518e753921ac847"
    }
    
    enum MethodsConstant {
        static let API_PATH = "https://gateway.marvel.com:443"
        static let characterListPath = "/v1/public/characters"
        static let characterPath = "/v1/public/characters/"
    }
    
    enum KeyNamesConstant {
        static let offsetKey = "offset"
        static let limitKey = "limit"
        static let nameStartsWithKey = "nameStartsWith"
        static let orderKey = "orderBy"
        static let orderByNameValue = "name"
    }
    
    init() { }
    
    func createRequest(url: URL, completionBlock: @escaping (CharacterDataContainer) -> Void) {
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            let dataModel = try! JSONDecoder().decode(CharacterDataContainer.self, from: data!)
            completionBlock(dataModel)
        }.resume()
    }
    
    func getHeroes(limit: Int?, offset: Int?, searchString: String?, completionBlock: @escaping (CharacterDataContainer) -> Void) {
        
        var urlComponent = URLComponents(string: MethodsConstant.API_PATH + MethodsConstant.characterListPath)
        urlComponent?.queryItems = getCommonParameters(limit: limit,
                                                       offset: offset,
                                                       searchString: searchString).map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        createRequest(url: urlComponent!.url!, completionBlock: completionBlock)
    }
    
    func getHeroDetail(heroID: String, completionBlock: @escaping (CharacterDataContainer) -> Void) {
        var urlComponent = URLComponents(string: MethodsConstant.API_PATH + MethodsConstant.characterPath + heroID)
        urlComponent?.queryItems = getCommonParameters(limit: nil,
                                                       offset: nil,
                                                       searchString: nil).map { (key, value) in
            URLQueryItem(name: key, value: value)
        }

        createRequest(url: urlComponent!.url!, completionBlock: completionBlock)
    }
    
    func getCommonParameters(limit: Int?, offset: Int?, searchString: String?) -> [String: String] {
        let ts = String(Int(Date().timeIntervalSince1970))
        let privateKey = KeysConstants.privateKey
        let publicKey = KeysConstants.publicKey
        let hash = "\(ts)\(privateKey)\(publicKey)".md5
        var parameters: [String: String] = ["apikey": publicKey,
                                            "ts": ts,
                                            "hash": hash ]
        
        if let offset = offset {
            parameters[KeyNamesConstant.offsetKey] = "\(offset)"
        }
        
        if let limit = limit {
            parameters[KeyNamesConstant.limitKey] = "\(limit)"
        }

        if let searchString = searchString {
            parameters[KeyNamesConstant.nameStartsWithKey] = "\(searchString)"
            parameters[KeyNamesConstant.orderKey] = "\(KeyNamesConstant.orderByNameValue)"
        }
        
        return parameters
    }
    
}
