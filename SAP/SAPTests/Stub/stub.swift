//
//  stub.swift
//  SAPTests
//
//  Created by Hamza Ahmed on 02/02/2022.
//

import Foundation

@testable import SAP
let mockHistory = History(searchText: "Berlin")
let mockHistoryCellViewModel: HistoryCellViewModel = HistoryCellViewModelImplementation(history: mockHistory)
func storeMockDataInUserDefaults(){
    UserDefaults.standard.saveHistory([mockHistory])
}
