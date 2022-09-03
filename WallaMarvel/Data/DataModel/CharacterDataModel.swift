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
        guard let isoDate = modified else {
            return nil
        }

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: isoDate)!
        
        let presenterdateFormatter = DateFormatter()
        presenterdateFormatter.dateFormat = "yyyy'-'MM'-'dd'"

        return presenterdateFormatter.string(from: date)
    }
    
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
