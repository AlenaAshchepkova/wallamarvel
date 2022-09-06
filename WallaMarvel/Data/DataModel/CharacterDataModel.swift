import Foundation

struct CharacterDataModel: Decodable {
    
    let id: Int?
    let name: String?
    let description: String?
    let modified: String? // Date in string
    let resourceURI: String?
    let urls: [UrlResponse]?
    let thumbnail: Thumbnail?
    let comics: ComicList?
    let stories: StoryList
    let events: EventList?
    let series: SeriesList?

    func modifiedDate() -> String? {
        guard let serverDate = modified else {
            return nil
        }

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: serverDate)!
        
        let presenterdateFormatter = DateFormatter()
        presenterdateFormatter.locale = Locale(identifier: "en_US_POSIX")
        presenterdateFormatter.timeZone = .current
        presenterdateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        return presenterdateFormatter.string(from: date)
    }
    
    // simple example with first url in array:
    // urls (Array[Url], optional): A set of public web site URLs for the resource.,
    
    func link() -> NSAttributedString? {
        
        guard let link = urls?.first?.url else {
            return nil
        }
        
        let attributedString = NSMutableAttributedString(string: link)
        let range = NSRange(location: 0, length: link.count)
        let url = URL(string: link)!
        attributedString.setAttributes([.link: url], range: range)
        return attributedString
    }
}
