import XCTest
@testable import WallaMarvel

class WallaCharacterDataModelTests: XCTestCase {

    var sut: DetailHeroAdapter!
    
    override func setUpWithError() throws {
 
        try super.setUpWithError()
        let view = DetailHeroView()
        let hero: CharacterDataModel? = nil
        sut = DetailHeroAdapter(hero: hero, view: view)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testModifiedDate() {
        // given
        let date = "2022-01-01T02:32:12+0400" // -> UTC
        sut.hero = CharacterDataModel(id: nil, name: nil, description: nil, modified: date,
                                      resourceURI: nil, urls: nil, thumbnail: nil, comics: nil,
                                      stories: StoryList(available: nil,
                                                         returned: nil,
                                                         collectionURI: nil,
                                                         items: nil),
                                      events: nil, series: nil)

        // when
        let checkDate = sut.hero?.modifiedDate()
        let expectedDateString = makeDateFromUTC(year: 2021, month: 12, day: 31, hr: 22, min: 32, sec: 12)
         
        // then
        XCTAssertEqual(checkDate, expectedDateString, "Modified date is wrong")
        
        // given
        let date2 = "2022-09-04T20:00:00-0400" // -> UTC
        sut.hero = CharacterDataModel(id: nil, name: nil, description: nil, modified: date2,
                                       resourceURI: nil, urls: nil, thumbnail: nil, comics: nil,
                                       stories: StoryList(available: nil,
                                                          returned: nil,
                                                          collectionURI: nil,
                                                          items: nil),
                                       events: nil, series: nil)

        // when
        let checkDate2 = sut.hero?.modifiedDate()
        let expectedDateString2 = makeDateFromUTC(year: 2022, month: 09, day: 05, hr: 00, min: 00, sec: 00)
          
        // then
        XCTAssertEqual(checkDate2, expectedDateString2, "Modified date is wrong")
    }
        
    func makeDateFromUTC(year: Int, month: Int, day: Int, hr: Int, min: Int, sec: Int) -> String {
        let calendar = NSCalendar(calendarIdentifier: .gregorian)!
        let components = NSDateComponents()
        components.timeZone = TimeZone(abbreviation: "UTC")
        components.year = year
        components.month = month
        components.day = day
        components.hour = hr
        components.minute = min
        components.second = sec
        let date = calendar.date(from: components as DateComponents)
        
        // move to current time zone
        let presenterdateFormatter = DateFormatter()
        presenterdateFormatter.locale = Locale(identifier: "en_US_POSIX")
        presenterdateFormatter.timeZone = .current
        presenterdateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let expectedDateString = presenterdateFormatter.string(from: date!)
        
        return expectedDateString
    }

}
