import Foundation

protocol APIClientProtocol {
    
    func getHeroes(limit: Int?, offset: Int?, searchString: String?, completionBlock: @escaping (CharacterDataContainer) -> Void)
    func getHeroDetail(heroID: String, completionBlock: @escaping (CharacterDataContainer) -> Void)
    
}

final class APIClient: APIClientProtocol {

    enum Constant {
        static let privateKey = "188f9a5aa76846d907c41cbea6506e4cc455293f"
        static let publicKey = "d575c26d5c746f623518e753921ac847"
        static let API_PATH = "https://gateway.marvel.com:443"
        static let characterListPath = "/v1/public/characters"
        static let characterPath = "/v1/public/characters/"
        static let offsetKey = "offset"
        static let limitKey = "limit"
        static let nameStartsWithKey = "nameStartsWith"
        static let orderKey = "orderBy"
        static let orderByNameValue = "name"
    }
    
    init() { }
    
    func getHeroes(limit: Int?, offset: Int?, searchString: String?, completionBlock: @escaping (CharacterDataContainer) -> Void) {
        
        var urlComponent = URLComponents(string: Constant.API_PATH + Constant.characterListPath)
        urlComponent?.queryItems = getCommonParameters(limit: limit,
                                                       offset: offset,
                                                       searchString: searchString).map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        let urlRequest = URLRequest(url: urlComponent!.url!)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            let dataModel = try! JSONDecoder().decode(CharacterDataContainer.self, from: data!)
            completionBlock(dataModel)
        }.resume()
    }
    
    func getHeroDetail(heroID: String, completionBlock: @escaping (CharacterDataContainer) -> Void) {
        var urlComponent = URLComponents(string: Constant.API_PATH + Constant.characterPath + heroID)
        urlComponent?.queryItems = getCommonParameters(limit: nil,
                                                       offset: nil,
                                                       searchString: nil).map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        let urlRequest = URLRequest(url: urlComponent!.url!)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            let dataModel = try! JSONDecoder().decode(CharacterDataContainer.self, from: data!)
            completionBlock(dataModel)
        }.resume()
        
    }
    
    func getCommonParameters(limit: Int?, offset: Int?, searchString: String?) -> [String: String] {
        let ts = String(Int(Date().timeIntervalSince1970))
        let privateKey = Constant.privateKey
        let publicKey = Constant.publicKey
        let hash = "\(ts)\(privateKey)\(publicKey)".md5
        var parameters: [String: String] = ["apikey": publicKey,
                                            "ts": ts,
                                            "hash": hash ]
        
        if let offset = offset {
            parameters[Constant.offsetKey] = "\(offset)"
        }
        
        if let limit = limit {
            parameters[Constant.limitKey] = "\(limit)"
        }

        if let searchString = searchString {
            parameters[Constant.nameStartsWithKey] = "\(searchString)"
            parameters[Constant.orderKey] = "\(Constant.orderByNameValue)"
        }
        
        return parameters
    }
    
}
