//
//  HistoryTableViewCell.swift
//  SAPTests
//
//  Created by Hamza Ahmed on 02/02/2022.
//

import Foundation
import XCTest
@testable import SAP
class HistoryTableViewCellTest: XCTestCase {
    private let reuseIdentifier = "HistoryTableViewCell"
    var sut: HistoryTableViewCell!
    var tableView: UITableView!
    private var dataSource: TableViewDataSource!
    private var delegate: TableViewDelegate!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 200, height: 400), style: .plain)
        let nib = UINib(nibName: reuseIdentifier, bundle: nil)
        
        tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
        dataSource = TableViewDataSource()
        delegate = TableViewDelegate()
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
    override func tearDownWithError() throws {
        tableView = nil
    }
    
    func testAwakeFromNib() {
        let indexPath = IndexPath(row: 0, section: 0)
        let historyCell = createCell(indexPath: indexPath)
        XCTAssertNotNil(historyCell.cellViewModel.history)
    }
    func testLabels(){
        let indexPath = IndexPath(row: 0, section: 0)
        let historyCell = createCell(indexPath: indexPath)
        XCTAssertTrue(historyCell.cellViewModel.history.searchText == "Berlin")
    }
    
}
extension HistoryTableViewCellTest {
    
    func createCell(indexPath: IndexPath) -> HistoryTableViewCell {
        
        let cell = dataSource.tableView(tableView, cellForRowAt: indexPath) as! HistoryTableViewCell
        XCTAssertNotNil(cell)
        
        let view = cell.contentView
        XCTAssertNotNil(view)
        
        return cell
    }
}

private class TableViewDataSource: NSObject, UITableViewDataSource {
    private let reuseIdentifier = "HistoryTableViewCell"
    
    override init() {
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! HistoryTableViewCell
        
        cell.cellViewModel = mockHistoryCellViewModel
        return cell
    }
}

private class TableViewDelegate: NSObject, UITableViewDelegate {
    
}
