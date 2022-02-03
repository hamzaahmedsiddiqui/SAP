//
//  HistoryViewControllerTest.swift
//  SAPTestTests
//
//  Created by Hamza Ahmed on 02/02/2022.
//

import XCTest
@testable import SAP

class HistoryViewControllerTest: XCTestCase {
    
    var sut: HistoryTableViewController! 
    var viewModel : HistoryViewModel!
    
    override func setUpWithError() throws {
        setupViewController()
        setupViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        sut = nil
    }
    private func setupViewController(){
        let storyboard = UIStoryboard(name: Constant.storyboardIdentifier, bundle: Bundle.main)
        sut = storyboard.instantiateViewController(withIdentifier: "HistoryTableViewController") as? HistoryTableViewController
        guard let vc : HistoryTableViewController = storyboard.instantiateViewController(withIdentifier: "HistoryTableViewController") as? HistoryTableViewController else{
            return XCTFail("Could not instantiate HistoryTableViewController")
        }
        sut = vc
        UIApplication.shared.windows.first{ $0.isKeyWindow }!.rootViewController = UINavigationController.init(rootViewController: vc)
        sut.loadViewIfNeeded()
    }
    private func setupViewModel(){
        viewModel = HistoryViewModelImplementation()
    }
    
}

extension HistoryViewControllerTest{
    func testTableViewExist(){
        XCTAssertNotNil(sut.historyTable, "Controller should have a tableview")
    }
    func testTableViewDelegateSetUpCorrectly() {
        XCTAssertTrue(sut.historyTable.delegate is HistoryTableViewController , "HistoryTableViewController does not conform to UITableView delegate protocol")
        
    }
    func testTableViewDataSourceSetUpCorrectly() {
        XCTAssertTrue(sut.historyTable.dataSource is HistoryTableViewController , "HistoryTableViewController does not conform to UITableView datasource protocol")
        
    }
}
