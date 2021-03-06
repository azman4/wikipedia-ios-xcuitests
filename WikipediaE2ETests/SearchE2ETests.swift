import XCTest

class SearchE2ETests: XCTestCase {
    // MARK: - Variables
    
    /// Instance of Common methods class
    var commonMethods = CommonMethods()
    
    /// Instance of Login Screen objects
    var search = SearchScreen()
    
    /// Instance of the app
    let app = XCUIApplication()
    
    // MARK: - Lifecycle methods
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    // MARK: - Skip Tour, Search, Recently Searched and Clear Search history Test Case Methods
    
    /**
     Method to test and skip app tour if it is displayed
     */
    func test01SkipAppTour() {
        app.launch()
        if(search.skipButton.exists)
        {
            commonMethods.tapOnElement(element: search.skipButton)
            self.commonMethods.waitForElementToAppear(element: search.searchTextbox, timeout: 10)
            XCTAssert(search.searchTextbox.exists, "Search Page is displayed")
        }
        else
        {
            XCTAssert(search.searchTextbox.exists, "We are already on the Search page")
        }
    }
    
    /**
     Method to test search functionality on the app
     */
    func test02Search() {
        app.launch()
        commonMethods.tapOnElement(element: search.searchTextbox)
        commonMethods.enterText(element: search.searchTextbox, value: search.searchValue)
        commonMethods.tapOnElement(element: search.searchResultList)
        self.commonMethods.waitForElementToAppear(element: search.searchedTextHeader, timeout: 10)
        XCTAssert(search.searchedTextHeader.exists, "Search Result is displayed")
        commonMethods.tapOnElement(element: search.wIcon)
        XCTAssert(search.searchTextbox.exists, "Search Page is displayed")
    }
    
    /**
     Method to test recently searched functionality on the app
     */
    func test03RecentlySearched() {
        app.launch()
        commonMethods.tapOnElement(element: search.searchTextbox)
        self.commonMethods.waitForElementToAppear(element: search.recentlySearchedText, timeout: 10)
        XCTAssert(search.recentlySearchedResult.exists, "Recently Searched Result is displayed")
        commonMethods.tapOnElement(element: search.recentlySearchedResult)
        commonMethods.tapOnElement(element: search.searchResultList)
        self.commonMethods.waitForElementToAppear(element: search.searchedTextHeader, timeout: 10)
        XCTAssert(search.searchedTextHeader.exists, "Search Result is displayed")
        commonMethods.tapOnElement(element: search.backButton)
        commonMethods.tapOnElement(element: search.clearSearchedTextIcon)
        XCTAssert(search.recentlySearchedResult.exists, "Search Text is cleared, Recently Searched Result is displayed")
    }
    
    /**
     Method to test clear search results functionality on the app
     */
    func test04ClearSearchResults() {
        app.launch()
        commonMethods.tapOnElement(element: search.searchTextbox)
        self.commonMethods.waitForElementToAppear(element: search.recentlySearchedText, timeout: 10)
        XCTAssert(search.recentlySearchedResult.exists, "Recently Searched Result is displayed")
        commonMethods.tapOnElement(element: search.clearSearchedHistoryButton)
        commonMethods.tapOnElement(element: search.deleteAllAlert)
        self.commonMethods.waitForElementToAppear(element: search.noSearchHistoryText, timeout: 10)
        XCTAssert(search.noSearchHistoryText.exists, "Recently Searched Result is cleared")
    }
}
