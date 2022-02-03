//
//  HistoryViewModelTest.swift
//  SAPTests
//
//  Created by Hamza Ahmed on 02/02/2022.
//

import XCTest
@testable import SAP
class HistoryViewModelTest: XCTestCase {

    var viewModel : HistoryViewModel!
    
    override func setUpWithError() throws {
        setupViewModel()
    }
    
    private func setupViewModel(){
        viewModel = HistoryViewModelImplementation()
    }
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        let domain = Bundle(for: HistoryViewModelTest.self).bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)

        viewModel = nil
    }
    func testCellViewModelForRow(){
        storeMockDataInUserDefaults()
        let historyCellViewModel = viewModel.cellViewModelForRow(row: 0)
        XCTAssert(historyCellViewModel.history.searchText == "Berlin")
    }


}
