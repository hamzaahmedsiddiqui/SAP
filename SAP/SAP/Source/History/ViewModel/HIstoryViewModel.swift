//
//  HIstoryViewModel.swift
//  SAP
//
//  Created by hamza Ahmed on 31.01.22.
//

import Foundation
protocol HistoryViewModel {
    func getHistoryArray()-> [History]
    func cellViewModelForRow(row: Int) -> HistoryCellViewModel
}

class HistoryViewModelImplementation: HistoryViewModel{
    
    func getHistoryArray()-> [History]{
        return UserDefaults.standard.loadHistory()
    }
    
    func cellViewModelForRow(row: Int) -> HistoryCellViewModel {
        let history = getHistoryArray()[row]
        return HistoryCellViewModelImplementation(history: history)
    }
}
