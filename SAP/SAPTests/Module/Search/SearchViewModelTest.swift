//
//  SearchViewModelTest.swift
//  SAPTestTests
//
//  Created by Hamza Ahmed on 02/02/2022.
//

import XCTest
@testable import SAP
class SearchViewModelTest: XCTestCase {
    var mockSearchService : MockSearchService!
    var viewModel : SearchViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        setupViewModel()
    }
    
    private func setupViewModel(){
        mockSearchService = MockSearchService()
        guard let mockSearchService = mockSearchService else {
            XCTFail("ViewModel cannot be instantiated.")
            return }
        viewModel = SearchViewModelImplementation(service: mockSearchService)
    }
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }
    
    func testCellViewModelForRow(){
        let expectation = self.expectation(description: "should recieve data")
        
        viewModel.didUpdateSearchResult(searchText: "Berlin", pageNo: 1) { [weak self] result in
            guard let self = self else {
                XCTFail()
                return
            }
            switch result {
            case .success(_):
                XCTAssertNotNil(self.viewModel.getPhotosArray)
                expectation.fulfill()

            case .failure(_):
                XCTFail("service failed")
            }
        }
       
        waitForExpectations(timeout: 10, handler: nil)
    }
    func testServiceCall()  {
        let expectation = self.expectation(description: "should recieve data")
        viewModel.didUpdateSearchResult(searchText: "Berlin", pageNo: 1) { [weak self] result in
            guard self != nil else {
                XCTFail()
                return
            }
            switch result {
            case .success(_):
                expectation.fulfill()
            case .failure(_):
                XCTFail("service failed")
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
}
