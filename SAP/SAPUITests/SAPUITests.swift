//
//  SAPUITests.swift
//  SAPUITests
//
//  Created by Hamza Khan on 03/02/2022.
//

import XCTest

class SAPUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false

    }
    func TestSearchBar () {
        
        let saptestSearchviewNavigationBar = XCUIApplication().navigationBars["SAPTest.SearchView"]
        let searchImagesSearchField = saptestSearchviewNavigationBar.searchFields["Search Images ..."]
        searchImagesSearchField.tap()
        saptestSearchviewNavigationBar.buttons["Cancel"].tap()
    }
}
