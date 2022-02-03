//
//  HistoryCellViewModel.swift
//  SAPTest
//
//  Created by Hamza Ahmed on 01/02/2022.
//

import Foundation
protocol HistoryCellViewModel {
    var history : History { get }
    func didSelectHistory() -> History
}
class HistoryCellViewModelImplementation: HistoryCellViewModel {
    
    var history: History
    
    init(history: History){
        self.history = history
    }
    
    func didSelectHistory() -> History{
        return history
    }  
}
